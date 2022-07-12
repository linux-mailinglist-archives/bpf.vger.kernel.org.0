Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0535711EE
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 07:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiGLFtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiGLFth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 01:49:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A258E1C3;
        Mon, 11 Jul 2022 22:49:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BNCLwF029001;
        Mon, 11 Jul 2022 22:49:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=07caagpZhhvg8BJDHOthsbbQ5X1+Ll99TMnMEijMsN8=;
 b=Vryj3C/0STjCumAb0w9CF5w1HXPfd+UNl599mvF2xvGH7yihiMZTBWOaSdw6jCBXX3yh
 zsnVEaPfT7xSERwHmYFA6y6CzjfiTp9ERPIqbSLC3yQamqocWs/sTzQCgxKKZGU5+YQd
 islMQ9TMV049YoIeJyTp5VVaDdl2ckC5yoA= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h8nndcvfq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBZc66fkfjaV/43d7HtN0qUT8WqRAoGh9t2BjSVl0e8evag6jKam+XrEAfuu8kUYfpHrLehazdjO9Q9y+uOQr2ubQEm2Fi2wvFJagIeYhLkcxwpXu3BKVTjUcESJVWizWx+9icJmwn4apJc/gmPXTxLgCVKE1d9j1TMubVnFl13UApHfrklyC4avvi48XelTiizeK8SpV16BX5qDJy1kduiMVY0E9KKsWSeFOPbKGLpCHZWrbjivn6tOo28zQgbY7X6sAsV9sRZx3JUXY6Ydx4nRBE2vCJ1+R2/aAuDAuXHexIzrzzXUEXmI8rKaDc8+vFgCAzjjAAyzpBUiXnfH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07caagpZhhvg8BJDHOthsbbQ5X1+Ll99TMnMEijMsN8=;
 b=m4Kl+RrGYnLwG5SB+WX3PP1eUTAXx++ALaCAb93gi4tyHzIf/p9GraBS0LVTQ6pyKFGJoR2U+I/ewE4gA0BZHkuYqyuBZJzXCOE+dtceVsxzudHzKJFy90v/faofvfRGrPRGhPmCZ+1CY19hcbApTC/f285hvxu+CKMKedSWuBwgQtAGPBps/TZxlOUoGqLWcjaHa253v3cB2WExg+/6UV12l/Mo+wBXFuYSmiMyez9jZzmfVrbR0NVERVYGijc9D7qLHZeogoVaNIIHXcK4f8q3MMR/6SWIE+suLSbBCflHJGm2wpqftQW1c5wkChxOk/HYVYtnmE6TWg7e5LP2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4187.namprd15.prod.outlook.com (2603:10b6:a03:2e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 05:49:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 05:49:32 +0000
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
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MAgADwxACAAEM5AIAAKMMAgAAvboCABOqLgIAAGVQA
Date:   Tue, 12 Jul 2022 05:49:32 +0000
Message-ID: <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
In-Reply-To: <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1e399bb-bfb0-4ee8-3d3f-08da63ca4b7b
x-ms-traffictypediagnostic: SJ0PR15MB4187:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iaLjseLnkTAysLtbrkh7Onl3+Lh2s/edeiPFdxHMX0vICoyNFxSVtMFpYhzH5yvytTYvuGHqndb/0FrjVUDAVO2lcdsyvC5Bqk9kLBgy1yTh8F73i2pFGkiO3wBF+jcIJveVG8+eigDDAw7PQgrFzg78i8KNtEaZdVS9n8Wc0JfOx4v5pVReGt5P5w2xAwce0vFnAfFJ/KcRFsvEVUQiqkRhJCD/6RBuo88k9i/6HKoPqJD5W+Qqf6Xa0g5OLtY5GLIHwiUnEvxw/c/Ym3u/La9dRIOcZTldQClTxbTzBg4oXXCtjUR4Eho/4YcTrBHo0n981KSEaL+2e3es/AjM3jhWa5YlCA2dTPpZOiFblnffw9HbIyU7aunTl5XVSzfsLT96hleAOF1Oxs+cJwE5q5uwm2o04OSDCToBWtIek3Cc2tive2I3K/LCgm+A/HPRUU8zXrEgCDkjt36NfJwC0jiE2poUfy0TBF3UDjZ9Xv2MRlo5IuK9jLbZ99B4EzC+IL9C9op0xh7/0Zfnz08lU4Tbp/bD9a6DCDAvND2R0i9k/j71MCVZqyIAXbptTYKUB06suRVs3njtNEIFhfjlHPfziezDC0iQkq0+lVw+/TMuLDYRO3l9omr5FWMvpGMCHS8kpv2vnXf46IEyLNSN5biGKcJPbTPWy5ZJylX4y2n4O9pLg8rRDNNKejbltcySmRL+ANg9eIh9gxSlpqQG+gPlLA9CQ7qUUywlxwOXa2DBuqV6NEYH083SR+Xp3cge8RkENc+8dDJrje+lc3wl+Lw6nqomMTLghRXpD9EPtbf61MdQJ1bL1re1RodlAccH/1z1EvvzGARk74nzCQa999LN2K8nscXzSrF4ROz6Ek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(66556008)(71200400001)(64756008)(8676002)(76116006)(53546011)(66446008)(66476007)(54906003)(2906002)(66946007)(86362001)(4326008)(38070700005)(41300700001)(2616005)(6506007)(6486002)(186003)(7416002)(8936002)(5660300002)(122000001)(316002)(33656002)(36756003)(38100700002)(91956017)(6512007)(478600001)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?44ZAj86K2qJdkELXlLTIePAzXKfucdWml4gsf5ZUglcXZZZoeYi9hyZtWUHp?=
 =?us-ascii?Q?lx3Hzn4JrNGSebtt8ydOhSXWOdFOmPcyQA0i0lnBuajpgEYxkdheJjd7yEbV?=
 =?us-ascii?Q?T+V72glX4d6VvqqKn+Sr+NowVSUeNJRWOmHeJGaMRoLlBbxhAfw6KQ4b3mp6?=
 =?us-ascii?Q?e3i/bfYWX5UN5Ot4y2DrD9enDTs+yJR9UKLXYMf7QOIJMpYCMrkchVBZllXH?=
 =?us-ascii?Q?RbuFfK0we4SfMBgzFDp10v6liDCELA20T+EmPau6r4wXNpgT7Lf6B76AlCZI?=
 =?us-ascii?Q?SSPR6LW2fFqNNY3awJoUgYU6Kry0fynjWhzindD5sxY9u0WqVM2qfPB6Tyqb?=
 =?us-ascii?Q?Unkh5sp8qO0dRdkSYOctOG61APF52TvFwqvHDk+W/wM2tDegkGNpj/hEMUiC?=
 =?us-ascii?Q?pYgJqHTDyoVZI7ImPkH+g+Q3ZK/4m11gYJOqerhp3/6NxhEWF3n/YmxhbSbx?=
 =?us-ascii?Q?6Jt9AOGa5S6U9UTxTgpxwh3FY2Zr6aoRufjmFaGOEu/dFbn9WwvxFbALlbde?=
 =?us-ascii?Q?jUbAToAIBo/ji7CgNR193nUZLnPXouAkkMyKhLYsPCO8QRJeDnKBuJVhA64c?=
 =?us-ascii?Q?9GOoX2hWR9FQBcwo6vsVUmLuFpNj/p0dU0/XUIvrNC+h5V953XYXK9onrYEG?=
 =?us-ascii?Q?P6GKKCnFn/umrwBI1UzFvJdnKmZem1+eElgMSlVNYrpOOYm+LPHiJdVhvZ3i?=
 =?us-ascii?Q?lnByUmDN/RmUoRuYVkw3y86eQAMO0J0Ztlo/nJ7yDkM/ljYQcd01xHgxCeYI?=
 =?us-ascii?Q?R9hU6xndbcRvPSBR3sNsKlYcWWf0y3igE4wHrAIKgzkzrgvrdnBaxsdMljtG?=
 =?us-ascii?Q?OPX9qocSSj3gmscKcKbgj03/qyb7DfifED7avtV3otciATKkG/zrRzQ3waWh?=
 =?us-ascii?Q?/PPgZCh3ygkVLquA4qBQq6ibmQirwdMFEsflwPfMEHxKftskjV3ZRudNB5XT?=
 =?us-ascii?Q?WYsKr0C7lAE9ftktizmLOyYNty47HWDTPqXMzr+EmAytapOS+OkjQXSaV/O+?=
 =?us-ascii?Q?nkfRycQQoibET+iiNsNdoXRbIf6MWY24G4BqC5vVwL7SS0jz8ulHWFspktmJ?=
 =?us-ascii?Q?d3HOj+VNXZaWsN0mCj3hcqKD5mBaQ5GTxrrHYdDfNpIwX6r3GMDUneDrzxUZ?=
 =?us-ascii?Q?+t6jU+ixgmuJ98uqMryLJtmjGcMgWwDdUmVp9bNRQbYy1q4jlWvHTrJiXby8?=
 =?us-ascii?Q?6j8kcebuW0eJsKOR5va7vVtx6vUEnS1y8f00Ev+hHjioPKuHniHo/iaQcs/W?=
 =?us-ascii?Q?ZVOiYxSmVxh+BlZ6pz+MEnTIQHpT2M44a//2Z1PySCFQF8iYkMV8v0GsUwaz?=
 =?us-ascii?Q?7r7+EFtXAOK2xxRmSdZlH1hhsHUCHu14pO1r0Bd4+s1RFfHloLysfT1/A/6i?=
 =?us-ascii?Q?XS0EMdOcB695534bO6adc7JeiGcisfPp9FQYT4lE/4RtOs58vqSuVXRoZlr2?=
 =?us-ascii?Q?YFUODkJXEfV3eF7J2WghMFEsF9AEWom355aNOZRrNIWprpTrvtpPa1tzeu5Y?=
 =?us-ascii?Q?7CbMcureWNBjcP+461Knb4AgREKcuAkipHsn0D/nGqfV0avZBTJMlJ7qbhIO?=
 =?us-ascii?Q?R87ZwiNYSAPsLAGWIBr0jfSL6YomOL8Fsm1RGnRwGR1XUEm+4KhY09JA66xC?=
 =?us-ascii?Q?pnziV3ZF1jbNEuKnLMen3q4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB940A73F2FAEE489B15DC3F980BAFCD@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e399bb-bfb0-4ee8-3d3f-08da63ca4b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 05:49:32.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNS1J8s24yXhcDyHXIQ/8SBBKFY4aQDGOczhj3geK5NwgeQ4N8PP8CfpEnAl/8R9bTqyFitQqSQ0viF5hv9qrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4187
X-Proofpoint-GUID: shPqxgxGZLE2nhC7MLrN7_0wZrJzudAA
X-Proofpoint-ORIG-GUID: shPqxgxGZLE2nhC7MLrN7_0wZrJzudAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_03,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 11, 2022, at 9:18 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Sat, Jul 09, 2022 at 01:14:23AM +0000, Song Liu wrote:
>>> On Jul 8, 2022, at 3:24 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> 
>>>> 1) Rename module_alloc_huge as module_alloc_text_huge();
>>> 
>>> module_alloc_text_huge() is too long, but I've suggested names before
>>> which are short and generic, and also suggested that if modules are
>>> not the only users this needs to go outside of modules and so
>>> vmalloc_text_huge() or whatever.
>>> 
>>> To do this right it begs the question why we don't do that for the
>>> existing module_alloc(), as the users of this code is well outside of
>>> modules now. Last time a similar generic name was used all the special
>>> arch stuff was left to be done by the module code still, but still
>>> non-modules were still using that allocator. From my perspective the
>>> right thing to do is to deal with all the arch stuff as well in the
>>> generic handler, and have the module code *and* the other users which
>>> use module_alloc() to use that new caller as well.
>> 
>> The key difference between module_alloc() and the new API is that the 
>> API will return RO+X memory, and the user need text-poke like API to
>> modify this buffer. Archs that do not support text-poke will not be
>> able to use the new API. Does this sound like a reasonable design?

[...]

> I believe you are mentioning requiring text_poke() because the way
> eBPF code uses the module_alloc() is different. Correct me if I'm
> wrong, but from what I gather is you use the text_poke_copy() as the data
> is already RO+X, contrary module_alloc() use cases. You do this since your
> bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
> module_alloc() and before you can use this memory. This is a different type
> of allocator. And, again please correct me if I'm wrong but now you want to
> share *one* 2 MiB huge-page for multiple BPF programs to help with the
> impact of TLB misses.

Yes, sharing 1x 2MiB huge page is the main reason to require text_poke. 
OTOH, 2MiB huge pages without sharing is not really useful. Both kprobe
and ftrace only uses a fraction of a 4kB page. Most BPF programs and 
modules cannot use 2MiB either. Therefore, vmalloc_rw_exec() doesn't add
much value on top of current module_alloc(). 

> A vmalloc_ro_exec() by definition would imply a text_poke().
> 
> Can kprobes, ftrace and modules use it too? It would be nice
> so to not have to deal with the loose semantics on the user to
> have to use set_vm_flush_reset_perms() on ro+x later, but
> I think this can be addressed separately on a case by case basis.

I am pretty confident that kprobe and ftrace can share huge pages with 
BPF programs. I haven't looked into all the details with modules, but 
given CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, I think it is also 
possible. 

Once this is done, a regular system (without huge BPF program or huge
modules) will just use 1x 2MB page for text from module, ftrace, kprobe, 
and bpf programs. 

> 
> But a vmalloc_ro_exec() with a respective free can remove the
> requirement to do set_vm_flush_reset_perms().

Removing the requirement to set_vm_flush_reset_perms() is the other
reason to go directly to vmalloc_ro_exec(). 

My current version looks like this:

void *vmalloc_exec(unsigned long size);
void vfree_exec(void *ptr, unsigned int size);

ro is eliminated as there is no rw version of the API. 

The ugly part is @size for vfree_exec(). We need it to share huge 
pages. 

Under the hood, it looks similar to current bpf_prog_pack_alloc
and bpf_prog_pack_free. 

Thanks,
Song
