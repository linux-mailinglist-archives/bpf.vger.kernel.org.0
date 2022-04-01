Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC94EFC5A
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiDAVvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDAVve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 17:51:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5F141FF2;
        Fri,  1 Apr 2022 14:49:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231LiLMC008796;
        Fri, 1 Apr 2022 14:49:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Z3tIO2ex4XoeXqRyQWxh7cKmJCtYjFHkMYVpkb7mTXY=;
 b=oMFzdwGkmk3aGN6Dc/48pnBN0pgxXcLUh6Yv5KPOtH7e6dpu0Mxlhuk9jBtqByYh8rtk
 02UEWNQErwVEfm0UaGs28sJgwjVzoFSOrE0Y4Op52luAzBUtVJAyJHq1JIgwG4Qhxweb
 tvjL6rPGJdH2LAoNW3/r6d2xqZCOtOOSYA4= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpf1wd5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 14:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fULbw3z0pFM+NHHJCLGkBAQ6mXiu7G34DPoj9LsqhMwMT6mqo05bJOZHMNDRzxWQhb3WTPtOm7d//IMwv/6429hEWsBewHXXTBPjNE1SP5IOGWB/ERCRGAEZdkhH7QY6i4zsvetySwq7/F9qWJ3vYZGM0p+zqVSiDXul7e0qOdBWFp3y10zt+OMviR4tahyTqzprkCcjzyGUiRPLf56NtCsdQnPH15zv6KVGCFLVvPzB6aKrqgbswhKh42owT+GI8X7XyGyGS+IubU3LXb+Oxhi+tETQeB/s5ahj58j1RQh/LHwO28LhGzKT3qpnND41vXxY7F+UvanT+grEJ3figw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3tIO2ex4XoeXqRyQWxh7cKmJCtYjFHkMYVpkb7mTXY=;
 b=mtXp0BspGUn8yrogqM2z6fZLqQrr0m1ufzHGhXyyyq+lhDES+F2O/OroebHmPZIFgeQrg6R3bRzsZOycQfjb3LuFWy45rdH7j44Q10Gvu7Q/S7B4E2Bki9lV3pt2r2RdRL+cib7JYFRcQJM9oB73MGmsicjRxIQENBHsTkb7qHAfz16walJryMjWH8JhXqkOfPoLy3IYRG/6VY6/QzuV93BGWv4uqxEvD7IfoyuU1BmpNF3JkR4oXlD7eNcUDF3SAgazU3qz3dXTHj65SU5XnZJa3oztrv9ob5z7Ld5vMdNEAqlFxmUSfxljpDBQKpjHl1tSsU3s1EFDJB0cle7/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 21:49:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::58c9:859d:dc03:3bb4]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::58c9:859d:dc03:3bb4%3]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 21:49:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: ftrace_direct (used by bpf trampoline) conflicts with live patch
Thread-Topic: ftrace_direct (used by bpf trampoline) conflicts with live patch
Thread-Index: AQHYRWVaJiYl6f5MqkeH0dgryMR1Y6zaSmkAgAABGoCAAU54gA==
Date:   Fri, 1 Apr 2022 21:49:39 +0000
Message-ID: <F5F02F6F-EEC1-4EB9-9755-97FF29D28A39@fb.com>
References: <0962AC9B-2FBD-4578-8B2F-A376A6B3B83F@fb.com>
 <20220331214836.663bc7cf@rorschach.local.home>
 <20220331215233.496479fc@rorschach.local.home>
In-Reply-To: <20220331215233.496479fc@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 618dc060-9e9b-4126-a30d-08da14298607
x-ms-traffictypediagnostic: BYAPR15MB3222:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3222EF0CADA6FF7AD4963F4DB3E09@BYAPR15MB3222.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WA2qYhBeDiwqGCBq4Hy/syOYbCeMDGAw6f8VOyccwJBl48vqu1BEcVyv+Cvi85zhCjsjjGkbWOaVa/7l/3+tt6AJ834lRVUaFjhf7i0ASNDMvk6hVagIPzp2IEEt5E0LbMs+x1ZNGGoiZQbG96lR6H8ulhJ8yVxX28j4CqfpQ5et+kbfi4DXSM9mfZFMBGFrtKAHSsXEFFEhGqxyd2sJODiw1Ps8Bvr7pSd2jDEGtY5TBL4kpfKirBgGb0qrh+u08SlomWyzMvzvP7RjpP+Zz/oxvcEtPHvvxd7EtTN/gzfveMBttyLwjhJf89hmCLZ44nrOystlxcUPvfzZqov3O/j78+hzYNzJ9gmuXJVcR32Dazds0cxK1tB4KL+GJ/o72jnCgMVCfp5say9DX5AKVHuMSsuuuuFHwpEjB11hHK88IJmkR643Wj2rOfRv2oXbQw7JJ+/4w4bZvldmE9OlEQn8wb+5fXzRWlf77RxAm+FpKs7JvqWSkWS/s2vdWUi2HqWP3XBowBqRISF5X10kUuoY5tFNeW9r/Iu1pZ56wNLMZzAVynAskBEv3ZgZHIERp42dci6mKCR+O6rcISNLlEVoINm6bsztM+H4hqN8MdZa+kWal2kvSjiy2hF2mffN9I+yOBPhLfDrbZispJpmmEc7YuxmUkAIm9zltSl1ruXlyKNTbtxwf6DkadqJYFhB5fUUKXyOIOBn/CrYI7xLZKtuH/y/SpfSmVORWZ7AFbtbgkGyal4jgNrZBtHACms
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(91956017)(66476007)(4326008)(66946007)(33656002)(186003)(66556008)(6486002)(66446008)(54906003)(76116006)(316002)(6916009)(508600001)(2906002)(8676002)(64756008)(6506007)(36756003)(122000001)(6512007)(53546011)(38100700002)(8936002)(38070700005)(86362001)(4744005)(2616005)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9s2LO7Ah/USa63GVtCTI+XOP/PiMaK8EO2kZHviJjiFIMJOl1HYADWZRWvyt?=
 =?us-ascii?Q?PSLKmPTNe7NeHqbthCN1g6TU5lOoBx5b3j90P4tA35rH775HTt2gjCvkkhVe?=
 =?us-ascii?Q?biC9YYbmr16EigzMRDQPDRG+zZJhpo05NV+3znhBcsx51tgexCL1nVWccwo+?=
 =?us-ascii?Q?2W6juIbQqRouucxlZiWRfHSYft4qVpRhtcXbfkE+vn+2/opTRqDo+PsqKOgo?=
 =?us-ascii?Q?44Wrb6VJFTDDQMdojIzsahyaVzI5RRGgJ0CnVUQn2/+y9Ng9j3MfC/MPTxG2?=
 =?us-ascii?Q?TMGaH5iuIM101Y+AqHu/6L49OwUbttfvUDkAF/t/LwKG0EVNd82jmniZoud6?=
 =?us-ascii?Q?DbxuBqiNtLL3nfN/2HY4Nd8VvtnFLlkVbIwJtSFBFF7gWUoHDuyb6Op3vvzK?=
 =?us-ascii?Q?Ojqm+vcIfz2Hd/vd9hccokImexiM/q8T2TKH0ABpMl8KkQ9pRSKCaM801aEK?=
 =?us-ascii?Q?GibczAhU+7rARZIsBaaj8YJBwdqdRh1DYcxdE8zGDuoVGFq4w47GvppZCCgK?=
 =?us-ascii?Q?ACoicJMG3wnfSOSKefvFu7XxjhSBF0OMALwBOYhfh+1B3X+jw4geDkT8TehD?=
 =?us-ascii?Q?1uxys1mCLAgL32DJkGhJbNbKiafoq9MLqh28jOhmUf+yuNaW+nQuELri1ds1?=
 =?us-ascii?Q?FXANLu9KJnW/hgE2yNMAuwWjvZ1h3J2j6UAxBdThTkJZweBvUVoQe/kdNmmN?=
 =?us-ascii?Q?pxK4suQUT0Fe8lEs1uz83WQUX6gdNG0b92TGeLY8Si2XWZmuqqBpT56MGBrq?=
 =?us-ascii?Q?G+soSCt00ep9EUINthgykOlyhDgTFc9NCa8uSMuXqoVOHMbHWT57cxl2ifWE?=
 =?us-ascii?Q?IXAz8Rq0/dCiHfmP9m6nAEKRPDPuNIg8zb6ExGqW/YEi24jHlVnvnaiX1m9s?=
 =?us-ascii?Q?OnpoMOwyqLqxvib2yElZGGFV6khNRVq69InY9yHR7LKNS7kZ8rUshwwZQzeJ?=
 =?us-ascii?Q?xWv9A5XnEj3rnDunphQGCUJlDx2m08mTds41jLiBTZCXNMAbtESI5Yw7hRV5?=
 =?us-ascii?Q?Pe4qIqDKegQefRkvCpMnr/CFQPkEFzIqq3fOIwjwxQ2dyO+ET8wnGMhTYblT?=
 =?us-ascii?Q?xAza9CCYpSrQAzfulvW0BUmv/ejflrAwaYmj1nZzv0RX6DAJNqdGsgxRT7CF?=
 =?us-ascii?Q?NpqkdAAMosEkwxdnUnYOd5H03UWpJHDg/2tcpt/1eSpgZLEyiv5buF9Ri4be?=
 =?us-ascii?Q?u7BptN6qeKFOzRonblMLjR9cMIOTK7PcrXen1vaMy+xeN+AdtZfzchNJHaqj?=
 =?us-ascii?Q?hgtX7BANA1pTrG7mpn7QCQ9oYgrYXfoAwq89ScCj1QU6mJ+S0qYy+nIKmbit?=
 =?us-ascii?Q?zu+asomUBuqK6pJx1OCu9kDMHj0BSklIZmbOSkTXul49ieq8hW8fefn4y6TV?=
 =?us-ascii?Q?h49GVLsjGoDubD0S7+y5dIFt65NEpD5apzza21M8SrteVG3RIF5zvUZckWnp?=
 =?us-ascii?Q?1JOB1VrCnci2CfCPP2+c6cQJZYmNapjMQQtuRdi8+m9hXs+EZcmrw3sqLqX9?=
 =?us-ascii?Q?5FKphYHB/KXGvf4IQXD8i9dbJ/hz9LyE9+DNqQjcSipTnj1pa2fdAegm/rjc?=
 =?us-ascii?Q?nEfkTIUoyLc5MeBB7fiotN2HfmVmqdz/w6wv9vqVMNDYB3IU5yrlJLi2iEHl?=
 =?us-ascii?Q?aUraj+VGEe/D55FOLSOlX6tYrLU1Z4oGa4F3Lx/i/ai5Ca6tPS/levchcKTj?=
 =?us-ascii?Q?wVlj5Qt75UJUKX0HpjMPrvpcCyBTWgz2RL6PI7TU7v/5uctyUkcAWoKDPi2G?=
 =?us-ascii?Q?TAHPhIESkQ5bE5gnyGl6CzIJIT/1DvoSDWliBjN4ll3hSf/lHras?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFC9CD529EEE50438E7E996CD5B17825@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618dc060-9e9b-4126-a30d-08da14298607
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 21:49:40.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um7uozFSNjIyd8m2Z/mtP9tbYU+9lfFzap3SuHSJ5VoG6nyjkoyxm2qqiDSyTou6E9pLATct3qPgCzhOe3gMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-Proofpoint-ORIG-GUID: 0GQ6-o7mhuB6x9cRNjp2Ri4zoW8yWCoj
X-Proofpoint-GUID: 0GQ6-o7mhuB6x9cRNjp2Ri4zoW8yWCoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_07,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 31, 2022, at 6:52 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Thu, 31 Mar 2022 21:48:36 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> Does this make sense to you? Did I miss something?  
>> 
>> I thought the BPF trampoline does:
>> 
>> 	call bpf_trace_before_function
>> 	call original_function + X86_PATCH_SIZE
>> 	call bpf_trace_after_function
>> 
>> Thus, the bpf direct trampoline calls the unpatched version of the
>> function call making the live patch useless. Or is this not what it
>> does?
> 
> Or perhaps you are only talking about the part of bpf that does not
> trace the end of a function?

Yeah, we do call original_function + X86_PATCH_SIZE if there is 
fexit or fmod_ret programs. So this alone is not enough to make the 
two work together. :(

Let me see how can we fix it...

Thanks,
Song

