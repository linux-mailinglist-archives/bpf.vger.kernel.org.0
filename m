Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8C52DCB6
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiESSZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiESSZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 14:25:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1618B;
        Thu, 19 May 2022 11:25:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JFGEGj013060;
        Thu, 19 May 2022 11:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=xp8cEqs8XOk0eM1vNqtjTNBka4IX4zJK4ddIrlgLPjs=;
 b=CnsJC9aLA1NaFs0z001mHyJIIA2EXgzbi1wyN1yJhnGsmwXA/qL7mIWpYnvEy9i9d9Nr
 ZJ+LMuqZO0iGbwG2cyZ4BAEtRIhMYPbnDv/Rm/l0DRKCxEHD9lAROgke1aKa+ALfhQGB
 nZazYYVEw2i1fJp8hXNjPk+6uNH580FuzXg= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d829nmj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 11:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4YQXllgR4k8Vdn1pssoyQQEf9rbp9Wxy7dRVryGjhHOD3p2pGuyOtSaQZh/5c7pTBfUs7dnd+AikpzDoMGGaUAXhvM7a4oawWBdUE6+9QlyeW7fTg693PyevCteI4BDijgryd4n5cLsnnOArOgpmvtYXjR9wlheRdzXWpiR133t2WcyrOCUV5HvA9o9KRevpRnRjGAE3GRkjKtcvtDzuti0/iUlMxWr6wWwvf3TbF7pBkCrdPF1SmrtkGNHDuk7iNyLlefxM/W1oJ5cP0mw4bAA32tr17ITK3ktaoxcdvAxw/2uE+dxGp1KkY3e9EcrRRWz27S/nf4sZCtj1MiL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp8cEqs8XOk0eM1vNqtjTNBka4IX4zJK4ddIrlgLPjs=;
 b=Cgt+hwZC98MsAFbO5B3t/eb673P1HFCdwS8JfKHqZRc1/aZ/qf26waazgw5ZpJsymrzzv8yxoN4d4PRUau8ReJSWVg2yw0IpGqzQxBPWZMjUTbEeZS/zAGSa4Nc3Wmz95/7MlMrIevB+a8Yo8K641CRiLZaCQI3oTvMvX2/pkNTyx5LSfjDdce9yz0rFSRz8Pjk0aDd/9JPiApMoE/Gl6sAoDoUExNq5Sg4rvijpUDc2ZS7J9gvk6ggEaY8usQTKaMlj0kBcrz87Mt+cjeA3JYy7PuMIPFbyhv0hcCVjJTOQYcBTdOjytS7Yla4sHgGQ5RZx6zWQ+ZrZ/0OeZMzCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN8PR15MB3412.namprd15.prod.outlook.com (2603:10b6:408:a9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 18:25:39 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 18:25:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYCAAC+jgIACAzQAgACrl4CAABjOAA==
Date:   Thu, 19 May 2022 18:25:39 +0000
Message-ID: <8C89EED6-6531-4144-BDA8-B6519396F67C@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-6-song@kernel.org>
 <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
 <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
 <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
 <E0C04599-E7E0-4377-8826-74FA073FC631@fb.com>
 <d3de84ce7fa62c9e460a49143ffa4709b6351390.camel@intel.com>
In-Reply-To: <d3de84ce7fa62c9e460a49143ffa4709b6351390.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d647ba-54c6-489e-efe5-08da39c4f9e1
x-ms-traffictypediagnostic: BN8PR15MB3412:EE_
x-microsoft-antispam-prvs: <BN8PR15MB3412085EA0A300A02E0CD2DBB3D09@BN8PR15MB3412.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: teszm9Up1AGN83l8nUuZI+lJwFCSJqVi/uwehsnREpgOs7BTQ6DWsL3e9araqHcuVwL2TBisJaUWnZPPNODp2znwnXVpxI9Hz5eUVl0Y/PdjX9LWTjEM14PjtKYOOcz7+SdCTkgTTHB8EcqydiB8w3299M+JWAmqHPhneZQeu+8QyDu0I8W1WZZIwRHW4puAUgmauWFWm8ndG8kRkZPVJ+22IrK/UDIG83JYVHhxkLDj8N2rRo0G1C78zmCQGrgmT3hwVZqSwLsO9R7ovzTMSKuZYpEdIzk303zTULmXC3h/mvpkYcF9jLYXP5wg3l7XF1LrPVg36s7X6tBctPL0kWWrlb18bgHE5OJsV1/zXWU1+JxT6MMRgmxM+xcQear7OPOkEtcKqXVi0Ta0iDa/sk3WcbFLsnyNAmbzkO41y3eKd8lFrSWFY0Rz3Hy7bu/RHixw0b4l3jJJYm1uy0ggDNjjCojMSQQLNO4Ig9jNJeMjomJJ+pcnVfepMnkjyG9y2lh89BFRrIIoqgI7cGobJhnnnY5dVzn29/s6ZUDBZu5ZLPYqNrb0PJ6RvzLYetjwc3ll6mweP0n0SNYCFzJeDTIYyfCHKQmjlA9hHMqmz32lQn+N29zeQR4lccHrG7HtUVDivVUFgzjORgaaFELWZdDyJUJuCF8D3CrsAfjAW+vjOyjCvgMyNy14SyY16A0OZ37OJ/vvSrNmRkElDCTSI1mEa4l5M99UgQAhfVVlPwhSQUEvJFWIliWM8OR5JwNp4WNVzZ5wvIaGVJo9HC2zwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(8676002)(64756008)(66446008)(66476007)(8936002)(508600001)(4326008)(66946007)(122000001)(6506007)(66556008)(36756003)(53546011)(6512007)(54906003)(91956017)(71200400001)(6486002)(2906002)(2616005)(33656002)(6916009)(186003)(316002)(86362001)(83380400001)(38070700005)(38100700002)(5660300002)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m6h/2vPF02xjF9BZ70Z7PzJQM2lD1XFHlkrjTsNbR9L4b8+TOV01iknpS0f0?=
 =?us-ascii?Q?tY4RHuxjoENvmtpWF8vc0Qm5YmvwDoHwVI613SVtDYUj9OXB5W2o917DxOnM?=
 =?us-ascii?Q?yMdy2/eHajOPIUhhjzNcGZMBDH/g21+hnoeguvqctvGs8qtPd4dIcTyySMSh?=
 =?us-ascii?Q?8HT5EWw0XachGxfgrAMcOStunOxujxTJTMpr/GvjHPIyKwXVHQYA99/30T+2?=
 =?us-ascii?Q?+I5Ikn7kkqQbGTNwrrpOIYO6tNRMychC6foOdwqAKVPQZu7NrXuSOHTT+29T?=
 =?us-ascii?Q?CHSBvsAbZ08Otg6wWniBuFlk0oKrnlka4Xrr7YRBuCUkZG/qrzD8zNcZln19?=
 =?us-ascii?Q?jWRfK9a4yp7TqKKXbl3KS7ERtI0ak5daOPdmqw269cQac3agXbkWPTqRgCRm?=
 =?us-ascii?Q?vjiwIkZd1RSL91yuImi93d8/F8DlPJCVjxqLKo3Q2REV8E81oCi5uT7Ihj57?=
 =?us-ascii?Q?40/+WlE+DDa9Xf5ub8I8m0LWLXjcI8UJLL0M8b6NmKnCIuBhEYE/SHPMZqOi?=
 =?us-ascii?Q?1UQcxjpw8ZfA9qvaoyRDyugui5SYRER0N3PuOetiGTZ9K9FmGA08McokEHE7?=
 =?us-ascii?Q?IfVgYbZwzfklbxfKqVzwml/ivTom3HHPo0jrZqqTQMtbBQ7R2LA4TtwECmtj?=
 =?us-ascii?Q?fE3q92P409FSleCS26zj3Z9vZ+op8P/TAQPCw0FlPmAAqRUCqysjgOMd4FeB?=
 =?us-ascii?Q?QsRh4ydsT6vUFHck2wXwQBxGBrIPV4xM+E63r9P7GimvnAw1r2h7L7OX2ZTf?=
 =?us-ascii?Q?ozZpeCcjcLQMcnmxiYfNEJJLqPf/RArY0Df/o5dz3y/XNeWmGqpRu16bg4L9?=
 =?us-ascii?Q?rEKRcrtMrEqIhwwOxCEcgNijPXqfGMSF6JO7o9U2mcUt1hh/w3kQ6cF3wkLa?=
 =?us-ascii?Q?//1SjC+pknayMPNxGYT/HJxzVxTj2GSCWzCwWUHgcEmwmFPRjdWotG0a/I0l?=
 =?us-ascii?Q?V/VMLH35afVRPOE8bAJxLEIYgi63QqTBS2wz94S5pkOIJjRX+MNsCRPvDK3Z?=
 =?us-ascii?Q?UPawOEUUoZz+Q7FJ91DO7wpagHywOnLknsnyk9v189uKwagrIDW1gvI+0ptb?=
 =?us-ascii?Q?CdsETsdpqW998+o2XfhKhvg2grHH9eAvDM20RMdaOxCVoL9bQhhMZ2xtU0OR?=
 =?us-ascii?Q?XEOkeZz9W6OvOMTBHAHzi6CooZslQO9Yj/dI15fjxfcU4GmKklcgVgx5La1/?=
 =?us-ascii?Q?0+ofuB7Ag66CoFDvK6uaWEP8U84BxDkiSCPmKAkdTJtqkjPYXg7/GaPOKIzF?=
 =?us-ascii?Q?dIlXkZYKbx7Sw49y7xNUqWt6ypUyrRg8QmFSavHvkj8QfXUUE3xeHocQMFZY?=
 =?us-ascii?Q?+AD8B02GvbXHiwaYUs9Ckqjf6CL1EYjzI90z4HsAAGiUjiRPL5oWGI52S+Vv?=
 =?us-ascii?Q?lZyLd95C/+sCMwHkPXRTeTYcs5nLSyO7AvTt6bBGa0IdLkTBFPdhiV7HaLRm?=
 =?us-ascii?Q?mZcoAqgpFtQBiFHUttZm4xDK6AVGW89LuiA5650nw3EE/tiG5CwTVBHkfoTl?=
 =?us-ascii?Q?vD5HuZ8xf6hleLSBMH759LCDwMxVOI/gAnpW3D+ifeIf0VrCPhbJY1Z0sFNJ?=
 =?us-ascii?Q?S468PaacoFTdT8BskUsdl64f+9EVaf1IvhmFipSCrUYuEwox/VCgvWmAcaim?=
 =?us-ascii?Q?khPw/du/V0+Wa94roHK/icrGSOoao5LYQmrhh372J0iR85VH0kwZ7+21RbQ8?=
 =?us-ascii?Q?WwBZ3NmzMa5sK5G0AeGVWDISEn9xjGNj71quot8qhBRBg6FH9kaevXPpCGWC?=
 =?us-ascii?Q?AB94SgQZW3X2CX6VDW+EQrtZNy2Poy75QrWLCSqO1cZ/UPxtZLe5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B52ABCBFD377E49964A4E19178B1658@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d647ba-54c6-489e-efe5-08da39c4f9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 18:25:39.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkA5w1ln6KRxNp8wUe0F7eYeEep4LUU8zLrRPGs0H6+5OKW+ywDQ6JcCrLK237BfeGGNZ3o+KzkRy9//3sGjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3412
X-Proofpoint-GUID: YUcqvisxirbnHpZo1WNRm6pY47QDimqq
X-Proofpoint-ORIG-GUID: YUcqvisxirbnHpZo1WNRm6pY47QDimqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_06,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 19, 2022, at 9:56 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Thu, 2022-05-19 at 06:42 +0000, Song Liu wrote:
>> Thinking more on this. Even huge page is not supported, we can
>> allocate
>> 2MB worth of 4kB pages and keep using it. This would help direct map
>> fragmentation. And the code would also be simpler. 
>> 
>> Rick, I guess this is inline with some of your ideas?
> 
> Yea, that is what I wondering. Potential benefits are just speculative
> though. There is a memory overhead cost, so it's not free.

Yeah, I had the same concern with memory overhead. The benefit should 
not exceed 0.2% (when 2MB page is supported), so I think we can use
4kB pages for now.  

> 
> As for the other question of whether to fix VM_FLUSH_RESET_PERMS. If
> there really is an intention to create a more general module_alloc()
> replacement soon, then I think it is ok to side step it. An optimal
> replacement might not need it and it could be removed in that case.
> Let's at least add a WARN about it not working with huge pages though.

IIUC, it will take some effort to let kernel modules use a solution 
like this. But there are some low hanging fruits, like ftrace and BPF
trampolines. Maybe that's enough to promote a more general solution. 

For the WARN, I guess we need something like this?

diff --git i/include/linux/vmalloc.h w/include/linux/vmalloc.h
index b159c2789961..5e0d0a60d9d5 100644
--- i/include/linux/vmalloc.h
+++ w/include/linux/vmalloc.h
@@ -238,6 +238,7 @@ static inline void set_vm_flush_reset_perms(void *addr)
 {
        struct vm_struct *vm = find_vm_area(addr);

+       WARN_ON_ONCE(is_vm_area_hugepages(addr));
        if (vm)
                vm->flags |= VM_FLUSH_RESET_PERMS;
 }


Thanks,
Song

> 
> I also think the benchmarking so far is not sufficient to make the case
> that huge page mappings help your workload since the direct map splits
> were also different between the tests. I was expecting it to help
> though. Others were the ones that asked for that, so just commenting my
> analysis here.

