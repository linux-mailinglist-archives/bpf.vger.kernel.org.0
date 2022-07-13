Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CECB572A90
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiGMBAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGMBAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:00:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F139C7490;
        Tue, 12 Jul 2022 18:00:42 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLk5cl018102;
        Tue, 12 Jul 2022 18:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=AoHv8MU4aQ6PNMhTZb3wZB9KIb1a/xzeTpOOzvh+HT4=;
 b=Ok+Q2wBg4KZ2UQhwk8PG9DEABDwTjNHgkIJFWxz67XSg4enytXNk/lS9zaf/SY/P3ko8
 aLLbcTKFU0zgIj8upV+E23fZrnctP86fHOyx2IbAnNDbqMwKy5B86OxHtcDIqM1UTSYA
 u67aXZ8hI8JkFgO+SioX1IPedHV/HbyCQ+8= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f0usc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 18:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJVpfPwXPww/7vNcXYrR3lfXuAKZ+6Cc84/+DtLy5SeTFya6sHO+393W6GxGRRB3ZmJAlKcv/eFURTo48hFYgygVhxxBsL/1QJcxfrodsuFgnBTSPE5ZY3IpcQgGL6xxQPDc4iWO9cYLpag0nuT5Lmpr3Rk89sidsmoEBLRg9jALCc8ffegG1psubzHm5VZhJobJOHpEsyIfzu7PdMSu1eUVyMSUUam3Yg5F2+1C1BrECcXKF1tucpPbhlPbO9pYafcRZ956Uz4Oarpvh0V4kIo2KBZJw8jZLffEs+UwKrTkjJpyxZfW2y1PfD+J/Zj6siuQGvAyGf3dKrSsevwr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoHv8MU4aQ6PNMhTZb3wZB9KIb1a/xzeTpOOzvh+HT4=;
 b=STdxIg6gHafWrLLwxTLQGvazFhn38NmSgy+kH18ZwCzD+reExNjcNNhS1n90WgVckRAsmTli81i7rNzbIpPfezxjYSdn9vAu7tmDIcHm0ti/cl/9srTxzJNr19Lpu/lpiuGDYiwLUcn/wiwQgM5H/c8DyewXsXf9/LBiKgF+7zL8DFuv5GdLrg8rgCpzvj88WxmUq/1/LEWm6QcXxnAMJ3TDRzXM+muz7pkQNLgDcTA8rCcPW7PQUOobnh34yX2vlmJsT2TrjJGFPdcLlnmNKE+L34UU76i5mmxCN/hJMC0ZXYgHqqAOcP9j1jukVO54Fhs54jcYuc0sjxN6mdeiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB2813.namprd15.prod.outlook.com (2603:10b6:208:128::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 01:00:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 01:00:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MAgADwxACAAEM5AIAAKMMAgAAvboCABOqLgIAAGVQAgADeG4CAAEVBgIAACGmAgAAV1QA=
Date:   Wed, 13 Jul 2022 01:00:37 +0000
Message-ID: <728C4142-0070-4B85-9085-260EFC959681@fb.com>
References: <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
 <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
 <Ys3FvYnASr2v9iPc@bombadil.infradead.org>
 <6CB56563-29E2-4CE0-BF7B-360979E42429@fb.com>
 <Ys4G4/dG6SGYV/iz@bombadil.infradead.org>
In-Reply-To: <Ys4G4/dG6SGYV/iz@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae795c5-22b8-4475-f63c-08da646b1962
x-ms-traffictypediagnostic: MN2PR15MB2813:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDi6kNGrrYzXfPHeTjcHAdL+mNnKhZMkFgcEDL20MP+NvJOWvtzyQ1H9iymxTaS+xLEuRqIM1AHf5cs647sszn6St1T8IAu5lowHVNi27eOrG/yEQs5K6+uZBIaQ1NTPfhxsNozB/Fl35EDn35D/KEfytsZXp7Kl5f7NEmjj1oHC2hkOQhiNNy6GLTpKPxJxUTjY28CzUMqp0tVutbFLVS9IDIotH0/JTkLGzQPSukE5vrZxkHUWe9dxrC4CRso453c5clihgH0h6N6soM13iPi3DMBFFjKp6ejJMJd9rWyUNr5YpN5n8ioMwxkwIaaT5+OstZseu9pBjBdIsD5atJkySghk3zt4XXh21AqXJQGZ1REsZ+TpC40cJWnl7FhjtOHZIzvq6js31aGfHMq4uAR272PN85PM+8BxdI058y4Igyab9ElBwitC8T2i5Eup7xDTjFFvIIgneO1b8hNawO1an5KYKHxi0BtTL6YcV4sRUb5njw9cR1CbCrC2mbHksNxasK+6xYhsqPR1SYhGyX1vnX3Fjg1xBQeXhDJYlv+Ci0kJn/dzeYLj0YudHFG5D7hcjDjZzL5n/7SIKrQXWuwud+ARF4aHDTvm+xxqKwjoakJCnPd1+Jw8scDOlevs4HLiEK8pt7vMgyrS6B+eFxr4uqH3mphFiVlopKxQOB2txwOzJ7qFMTg40vGminp1zqQiAJw6/CXtk7n1x8RqcXwYn5qnTrbBQi5UCMMUdaHCiPjAkqNIBDg7ZAH1h2H57HJXviSdZEBYdu6Ca/4QHxLkXuXhdPRQvfrnrjnQ6kAV6MKNOkSua17Y7l3FK8cMWfix+gkS1Js4gO07ALPCUNM0bpODcxABWTvBfmtlxR8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38100700002)(66556008)(91956017)(66476007)(8676002)(8936002)(66946007)(64756008)(7416002)(66446008)(122000001)(76116006)(83380400001)(5660300002)(86362001)(6512007)(186003)(2616005)(478600001)(6506007)(36756003)(53546011)(38070700005)(54906003)(4326008)(6486002)(6916009)(41300700001)(71200400001)(2906002)(33656002)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zJM/HR/ST/MsQMid6wGvSYhdx4+zjYmy5L2bu3TbVyhdbdMZiFGmBP+bpcGs?=
 =?us-ascii?Q?oypPMxtAb7pegOK6G+1axMByKd4dmH8J8pJssAtoLbdp5zkd57BQ9T66F2Z0?=
 =?us-ascii?Q?Y2f5QPotR6Ls1WIcUKN8I0C47g3UboTrtYdfwaMigjn+2uB0+y/ndloLwyl0?=
 =?us-ascii?Q?kjkSEORRyRUMyIYdlUkbHxc5RLYVLMqxw1AjsMW8UfvxlroIU1nO470iT63z?=
 =?us-ascii?Q?qmyrjcB9i6xLCF40quU7Erq/8r0cr1dddB5AoY9FNRT2+6+6whvW1thQ+l8l?=
 =?us-ascii?Q?F+najP8/5xpYgt26Le1x3NhbzHa34tGxpYaEVuqrRpfLgxAyzdsiFMfDV+Zn?=
 =?us-ascii?Q?FFDU2sA/2hZG6iSe+Nq4uRC87Ymwx27JiYGeFKvrvVtuQwhnTFcKf1ljk7+u?=
 =?us-ascii?Q?8ZFugXnzcZBM0DlbqZ8NBXyqVWf+7kuZUB6Rci/Laj2KPOLMVUmNhV1W2j+h?=
 =?us-ascii?Q?wrDgpZPi/yKbp/Et3qjVBBFhqqqeLecl5NKeCO/S8Bu36Yc8rGtYTWXQ/S9f?=
 =?us-ascii?Q?tzuSS0yCPYk/bZSD/ibnvHJWd6wRPk1dKQLEvF5y6hufnQqRO3fkwd/EO4ma?=
 =?us-ascii?Q?urMCl56eZTOpn3sSWsMQOsQlk+2GU+vZ3QUJ3/Die7jCmudcKWsK3O8c0yeP?=
 =?us-ascii?Q?S0X/hoffk6IV7nV3x/ZwGIg9tG/AxzN0V6dTganb7e43Whf/plKwjpgX5Jpv?=
 =?us-ascii?Q?ciwBQsqWxp6W12zB48wZ8VaLqYKSdX8oq9NffaKLM6+UPo/VmBrvOgtmUu67?=
 =?us-ascii?Q?Nn9HCFI6/RFVyCO4YGqyij/5z4EI2JC81s6Nm9x4liWPOUTf+rM6FQbNUdGG?=
 =?us-ascii?Q?WAEPC4SkINtIIFoJ43UMNyhF3gcUq+HrrVTqFtAKg59ens6OeHIGNW0iZyNu?=
 =?us-ascii?Q?aesAGC1EfpuZEOCfC4whmA3+UQaFsCLXSgxghq46psmjWxmJx5Bagk9qYZ4u?=
 =?us-ascii?Q?GsFBqUBwxKN+pwmUYWerkpNAHQXzFYd1PPyyHI4j+Mtr/d30EAjLYqwFjFrm?=
 =?us-ascii?Q?t9KeUIjjfB5VelZG2CJzUwwU1zjgO0+JfB1RtQ5/PGWX7riR1n+/4X0H08wn?=
 =?us-ascii?Q?9r49SNKs2KZwGi2UFBtHDWMZaRqmCYRRR2tjsJZf2eHuzFib8JGG9WsEmnvS?=
 =?us-ascii?Q?eWm0P722aswE68L52D2kxFcIKpfd0VSdkZ/JYNTasVCFQVoh0B+zl3M8wJhA?=
 =?us-ascii?Q?yIQCapgF4uJMt/FnBjKCVVIIam+egbTb6a4zFkRQnG4h8Ojhu+tCKD30Cdeb?=
 =?us-ascii?Q?k1mS5PKihSwLDmc972Kgs9wC9o953ixyO9yY96QvPYaOPCUScvbbgSOsAVi4?=
 =?us-ascii?Q?a0jbzJoyIMycxOqfulqdY+K785ML1LKLT7QPUSVFfvVeHi1LTa9IoL6rLwCU?=
 =?us-ascii?Q?Tbj/uGAdHTzGiJJsgReFGhNFRQGwqEbD+jNI5Nsrdd+AJiBk1RlH325nsXfR?=
 =?us-ascii?Q?s5yygJKkHMTarjyEfrlSUhVLtrTtsQk6zU+sXmYxUKh3b91O8c4dzcMLi7bW?=
 =?us-ascii?Q?2qRWpveR0N4TEkoknKsGLgHmz798UDafZncVGeWsNXE06YZ3dBjYonEf7htV?=
 =?us-ascii?Q?yCXmKMIdPz8R+BSzOTflIbiAJZo/vLw8ISrU8AoudaO7S1CWkRVxvGGjMKHR?=
 =?us-ascii?Q?/oScHCX33l5SR3xQGLtvXFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29F3282AA9BBE54E93CE7512CE4F72FA@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae795c5-22b8-4475-f63c-08da646b1962
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 01:00:37.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pd/iiYBWmAYHhOTNNMkVg2mOpSAO6kOzUugy9ttzu9fxQduSzz0pTvWWGxh1PjnA/g8Sj5SrUdMwaQbPPSRScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2813
X-Proofpoint-ORIG-GUID: izKhQGTm_14PMeCmgKs3m-f7mGXDNq6n
X-Proofpoint-GUID: izKhQGTm_14PMeCmgKs3m-f7mGXDNq6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 12, 2022, at 4:42 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Tue, Jul 12, 2022 at 11:12:22PM +0000, Song Liu wrote:
>> 
>> 
>>> On Jul 12, 2022, at 12:04 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> 
>>> On Tue, Jul 12, 2022 at 05:49:32AM +0000, Song Liu wrote:
>>>>> On Jul 11, 2022, at 9:18 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>> 
>>>>> I believe you are mentioning requiring text_poke() because the way
>>>>> eBPF code uses the module_alloc() is different. Correct me if I'm
>>>>> wrong, but from what I gather is you use the text_poke_copy() as the data
>>>>> is already RO+X, contrary module_alloc() use cases. You do this since your
>>>>> bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
>>>>> module_alloc() and before you can use this memory. This is a different type
>>>>> of allocator. And, again please correct me if I'm wrong but now you want to
>>>>> share *one* 2 MiB huge-page for multiple BPF programs to help with the
>>>>> impact of TLB misses.
>>>> 
>>>> Yes, sharing 1x 2MiB huge page is the main reason to require text_poke. 
>>>> OTOH, 2MiB huge pages without sharing is not really useful. Both kprobe
>>>> and ftrace only uses a fraction of a 4kB page. Most BPF programs and 
>>>> modules cannot use 2MiB either. Therefore, vmalloc_rw_exec() doesn't add
>>>> much value on top of current module_alloc(). 
>>> 
>>> Thanks for the clarification.
>>> 
>>>>> A vmalloc_ro_exec() by definition would imply a text_poke().
>>>>> 
>>>>> Can kprobes, ftrace and modules use it too? It would be nice
>>>>> so to not have to deal with the loose semantics on the user to
>>>>> have to use set_vm_flush_reset_perms() on ro+x later, but
>>>>> I think this can be addressed separately on a case by case basis.
>>>> 
>>>> I am pretty confident that kprobe and ftrace can share huge pages with 
>>>> BPF programs.
>>> 
>>> Then wonderful, we know where to go in terms of a new API then as it
>>> can be shared in the future for sure and there are gains.
>>> 
>>>> I haven't looked into all the details with modules, but 
>>>> given CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, I think it is also 
>>>> possible.
>>> 
>>> Sure.
>>> 
>>>> Once this is done, a regular system (without huge BPF program or huge
>>>> modules) will just use 1x 2MB page for text from module, ftrace, kprobe, 
>>>> and bpf programs. 
>>> 
>>> That would be nice, if possible, however modules will require likely its
>>> own thing, on my system I see about 57 MiB used on coresize alone.
>>> 
>>> lsmod | grep -v Module | cut -f1 -d ' ' | \
>>> 	xargs sudo modinfo | grep filename | \
>>> 	grep -o '/.*' | xargs stat -c "%s - %n" | \
>>> 	awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'
>>> 60001272
>>> 
>>> And so perhaps we need such a pool size to be configurable.
>>> 
>>>>> But a vmalloc_ro_exec() with a respective free can remove the
>>>>> requirement to do set_vm_flush_reset_perms().
>>>> 
>>>> Removing the requirement to set_vm_flush_reset_perms() is the other
>>>> reason to go directly to vmalloc_ro_exec(). 
>>> 
>>> Yes fantastic.
>>> 
>>>> My current version looks like this:
>>>> 
>>>> void *vmalloc_exec(unsigned long size);
>>>> void vfree_exec(void *ptr, unsigned int size);
>>>> 
>>>> ro is eliminated as there is no rw version of the API. 
>>> 
>>> Alright.
>>> 
>>> I am not sure if 2 MiB will suffice given what I mentioned above, and
>>> what to do to ensure this grows at a reasonable pace. Then, at least for
>>> usage for all architectures since not all will support text_poke() we
>>> will want to consider a way to make it easy to users to use non huge
>>> page fallbacks, but that would be up to those users, so we can wait for
>>> that.
>> 
>> We are not limited to 2MiB total. The logic is like: 
>> 
>> 1. Anything bigger than 2MiB gets its own allocation.
> 
> And does that allocation get split up into a few huge 2 MiB pages?
> When freed does that go into the pool of available list of 2 MiB pages
> to use?

This would have some 2MiB pages and some 4kB pages. For example, if we 
need 4MiB + 5kB, it will allocate 2x 2MiB pages, and 2x 4kB pages (round
up to 8kB). 

On free, the will not go to the pool. Instead, it will be vfree()'ed. 

> 
>> 2. We maintain a list of 2MiB pages, and bitmaps showing which parts of 
>>   these pages are in use. 
> 
> How many 2 MiB huge pages are allocated initially? Do we have a cap?

Current logic just allocates 1 huge page at a time. No cap. 

> 
>> 3. For objects smaller than 2MiB, we will try to fit it in one of these
>>   pages. 
>>   3. a) If there isn't a page with big enough continuous free space, we
>>        will allocate a new 2MiB page. 
>> 
>> (For system with n NUMA nodes, multiple 2MiB above by n). 
>> 
>> So, if we have 100 kernel modules using 1MiB each, they will share 50x
>> 2MiB pages. 
> 
> lsmod | grep -v Module | cut -f1 -d ' ' | \
> 	xargs sudo modinfo | grep filename |\
> 	grep -o '/.*' | xargs stat -c "%s - %n" | \
> 	awk 'BEGIN {sum=0} {sum+=$1} END {print sum/NR/1024}' 
> 271.273
> 
> On average my system's modules are 271 KiB.
> 
> Then I only have 6 out of 216 modules which are use more than 2 MiB or
> memory for coresize. So roughly 97% of my modules would be covered
> with this. Not bad.

Are these all the modules we have in tree? ;)

Thanks,
Song

> 
> The monsters:
> 
> lsmod | grep -v Module | cut -f1 -d ' ' | xargs sudo modinfo \
> 	| grep filename |grep -o '/.*' | xargs stat -c "%s %n" | \
> 	sort -n -k 1 -r | head -10 | \
> 	awk '{print $1/1024/1024" "$2}'
> 6.50775 /lib/modules/5.17.0-1-amd64/kernel/drivers/gpu/drm/i915/i915.ko
> 3.6847 /lib/modules/5.17.0-1-amd64/kernel/fs/xfs/xfs.ko
> 3.34252 /lib/modules/5.17.0-1-amd64/kernel/fs/btrfs/btrfs.ko
> 2.37677 /lib/modules/5.17.0-1-amd64/kernel/net/mac80211/mac80211.ko
> 2.2972 /lib/modules/5.17.0-1-amd64/kernel/net/wireless/cfg80211.ko
> 2.05754 /lib/modules/5.17.0-1-amd64/kernel/arch/x86/kvm/kvm.ko
> 1.96126 /lib/modules/5.17.0-1-amd64/kernel/net/bluetooth/bluetooth.ko
> 1.83429 /lib/modules/5.17.0-1-amd64/kernel/fs/ext4/ext4.ko
> 1.7724 /lib/modules/5.17.0-1-amd64/kernel/fs/nfsd/nfsd.ko
> 1.60539 /lib/modules/5.17.0-1-amd64/kernel/net/sunrpc/sunrpc.ko
> 
> On a big iron server I have 149 modules and the situation is better
> there:
> 
> 3.69791 /lib/modules/5.16.0-6-amd64/kernel/fs/xfs/xfs.ko
> 3.35575 /lib/modules/5.16.0-6-amd64/kernel/fs/btrfs/btrfs.ko
> 3.21056 /lib/modules/5.16.0-6-amd64/kernel/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko
> 2.02773 /lib/modules/5.16.0-6-amd64/kernel/arch/x86/kvm/kvm.ko
> 1.82574 /lib/modules/5.16.0-6-amd64/kernel/fs/ext4/ext4.ko
> 1.36571 /lib/modules/5.16.0-6-amd64/kernel/net/sunrpc/sunrpc.ko
> 1.32686 /lib/modules/5.16.0-6-amd64/kernel/fs/nfsd/nfsd.ko
> 1.12648 /lib/modules/5.16.0-6-amd64/kernel/drivers/gpu/drm/drm.ko
> 0.898623 /lib/modules/5.16.0-6-amd64/kernel/drivers/infiniband/hw/mlx5/mlx5_ib.ko
> 0.86922 /lib/modules/5.16.0-6-amd64/kernel/drivers/infiniband/core/ib_core.ko
> 
> So this may just work nicely.
> 
>  Luis

