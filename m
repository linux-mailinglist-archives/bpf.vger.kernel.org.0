Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFF604CBD
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJSQGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJSQGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 12:06:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6964DE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:04:46 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEFWkf031296;
        Wed, 19 Oct 2022 09:04:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=h92fMrannUiNt03NSAc9w/RN0U1PcMStTHZuMvNkqT8=;
 b=N0KyTvqj9dg6tLCO6glkTAYxSBZmX/5g5L6Z9w7kECpLP9YvVbaaVn2WH2z5xly7X73y
 Kl+Co2kx+YppDKG73FWubvHw+q2wPQT710IHvihXPYnopwY5oGI4bWT+rNUD0S7otFX4
 qUNLHh/u8hYQqv7smW/z/Xys8c08kGq+AzRizK3Bk+5Tzti8njJVDyhGhgU8hkMHAfs/
 FbvzdMc3pFHKFq5+mOX87ix0r+XH2WXrE0OG4m6fDHX2RiOUeG6qZAWzu4w3fqqpT3f4
 WJjckuOrw6h3R8PxPRBE4PDo5NspUolRr3vZGzoNlhAtZWFcuskhLu2lFKLwfWaQzzPN LQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ka6e8fgyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:04:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5VV+4Oti8ksQds+CW9PtAzfufLf6Vzuu4tt+jyvF7iQ+CF8O3XigCni76x/+CW8gv8KPddTyxXCSijiEO0PaiIA08droqiVs5qyX7Yvhgt2DC7sPo7COSdf9EkOLE3Ht+6EJP9Bc2ps1fZ9S/MNdi9Rk5lHDyg5m/fkGa3zIoKZjcAmZp8F/LkzRf0xetjSs0h09I1jOCGFJ/Xjw0jnssCDfsuqWsvqevBGoAKEyLdc0j44E6Zl19w3UuZgH+LM3BmmJAbk96Pg0x+xgOsGUPBVDlH7wCcQn7H3d4WbOSj4wuYusvcLcMSKZ/cBWKkAeQ2m2Pn/6yAxrMORcnWNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h92fMrannUiNt03NSAc9w/RN0U1PcMStTHZuMvNkqT8=;
 b=BtscPpsrqXUCUEqaQ0eV9OamiVosPmwBtWCSCRR+89gqoKL9fFDM9HqIF8LuQGNoi75RqNVqfmaDmTtI4x6oQYd54foKApwy1ZlkddxFPQw2GvzRgSjZOq82ENDkY6bNG0ZD9ip5a/WN33tS4MSYX4sDwl7wu8sMzf2oKYX2TmRuyJJUL+28dO3OTHfum7zk6149VGV36ylMftq4W4HSJcvYfdrKWsb0F4VYigMZUOHcTXpT6qREFML+6MecRouHsg7FQdzBuaU0ZhRecSsrlNk0/qIWJWGnXXv2lZPqho2yCak6rUyUV4wdJvEDbTJkxSDgBIzM9P4wndzrpMyGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BLAPR15MB3923.namprd15.prod.outlook.com (2603:10b6:208:276::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Wed, 19 Oct
 2022 16:04:26 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 16:04:26 +0000
Message-ID: <9fa8c693-6673-7bdf-c095-746b209e5ece@meta.com>
Date:   Wed, 19 Oct 2022 12:04:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v2 bpf-next 2/3] libbpf: only add BPF_F_MMAPABLE flag for
 data maps with global vars
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Stanislav Fomichev <sdf@google.com>
References: <20221019002816.359650-1-andrii@kernel.org>
 <20221019002816.359650-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221019002816.359650-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::6) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BLAPR15MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abb380a-1680-4366-02f9-08dab1eb9863
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slJWGcHVJ4km9Hzp3BduIv28GYJ3uqOZpVRi7LC71dfO9uqEH95rQXEIzfWXe70GA8MTYxsg0R4M3ZwClWKl4UysXs2r6IK1RucP3rU6e8bh6fIzqUPhceM7mCLXBmpct6JnUaeU6Dx8A7r/LAzL00VBX5eW+8amkAeNO/dO6Qfy+srZVsa5JVM3Rbu4x3krVMy3JHcGuXlIdsUUxKSs7MH+l651Vwji7p+B+caW5QMcOQryCgWoCFGKCtX1LAsTEdDWtvbaGF5B9vDUKet2d8xU1VSkAhx8bnHKAgMM+N8/MoeFAhaLCR71Hb1kecjvIm1qXYDkl8FX3ljg6JSAlzlnjJW1zAGtvCbbRExS7jgwOfYuOv1GywCu7bZiCX93hgGgvm0OaZFwJ9ZG8a2c6C9qcGhFQa4UmzZqDBc9jrvSKpM7PqbYqzQcj1sgcuqu/c2u61DtM8dNCqa+8j7J0Qa4cu1osIGCBdTaYfvLqJqm+2L7D/Jnoc+TeFHA2usH2h515uNt8L2aY2t4AQWkRfOribrRvhu167wfVW5PIDJ8kkc8UgxMqUBlyKxKgPYYG5baB6x9oYCJCX3QUCTvha0SISPwlmEm1oLcq6MtSrH/MNNp20oDg7ydJX+cWBTVMZnOKiCRmhDp40YTHDiUDmcroeSBRBObs/FaRm4UfpQYg6lQZJeic1/KkXYGMaOeRxsgudTkIZs6wEkw7fyQv3JC5R3JUqapqq5hk/8nesQUV+6mV1pWRFC4s+kdTk7LSsV8Hs9voFyLGKMFUU9HB+zrzfQpjcsHF9v8mffmVVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(31686004)(4326008)(66946007)(2906002)(2616005)(38100700002)(5660300002)(83380400001)(186003)(31696002)(86362001)(66476007)(53546011)(6506007)(6486002)(6512007)(66556008)(316002)(8676002)(8936002)(36756003)(41300700001)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFmMnRpazRzV2NvVDYvUDNJeWxjbHVUWFRIMXFSSmlRMUY1UUJmSzVOMm1B?=
 =?utf-8?B?Z2NES3pBT1VBQTBaRWtVcE0reXVqdXJSeVdTdk9uNEVlRUNDZHhsMDdOdTMv?=
 =?utf-8?B?MThUY0VEUUZKQm5QMS9zVTBJV1lzaituUExHZlVISit0SndidHI0Wk5ncUJy?=
 =?utf-8?B?ZkdJWXdiS0JtSlU0UmJaQU90aTNwY01FbG9xdmxXdTE1WUdWSlF4aUNuQW1k?=
 =?utf-8?B?WEVZbU5OR3RYN1BOdm45SU4zSUI3MmxuejF4UEhGK0NEdStyUjNGbFY0YW5L?=
 =?utf-8?B?SzMxamRWSTBWOFY4a2FxK3NuQUFaMmNOVWtxeVF2MHNDOGdmRCtMcmxBc1Ir?=
 =?utf-8?B?dmNWZzhKNFZUQTFzSm9sRHV2VmxCb1Y5QUZsYUo4RTZYMnhkMnBTQTJGVUVz?=
 =?utf-8?B?bGJ5eHYwK0Zab2crVGd6T25ndEdqYzRuSXdRVFF5WFpiNXA5aDhYOUJZTTZ5?=
 =?utf-8?B?WU4xMSsza2hjQ3k2N2JNaTZlbmFRUWNJNmpYTFhlOU9Jai9qSmpDc3pMZXI4?=
 =?utf-8?B?WXlPTy9Jb1lna2tGM2tCZ1ZzMVJaTVlXcHUwcjgrYlJRUFFicG43QXVtNVRq?=
 =?utf-8?B?YURpbjRsWHJJWGhJc0w5OGVCeStUdDJPZGpVNER0YjgybG92TGVucDIwaTRn?=
 =?utf-8?B?ZThRVW1melBHNUk1aURMdDN1aWJ5WUYwS0ZmQ2d1SjRUaWRJSTVuOXVLcENG?=
 =?utf-8?B?MVJZdDVZR2pkaWg2Mk5TcUdzM2t3dExqRE1CSEZWUUg5RlFxN0ZIRHBqYWNo?=
 =?utf-8?B?d3NEclJBSTZkZU1McHRWRkdUM2NEVFBGaW41d2J6djBGZFdpTXJQVjFGSHBI?=
 =?utf-8?B?dThTQWpQSXdYa1pSSXJFYnlSZjh1YkFBOU16S3dvTWFIdkdxSHZzWmVhQUpt?=
 =?utf-8?B?bUtWNW84eURiQmhpNWhvblhpOG44L0w4K3JoVkpGaU16aDdPNG5kampURUho?=
 =?utf-8?B?OVdYR3pzNUFPT2NhbFRxNUI5d1duTlRqY2lRemtQanNhQmdJM3ZNNGV5bFdY?=
 =?utf-8?B?U25hWGk3SStZRFdXUThtd1JzeDhTVXFqMWFsSzBodXlVOHpqMzZiTHUvckRs?=
 =?utf-8?B?L1FFZi8wM2dRdGJ1SEUzeHUvREpTNHZwYmE5N1hSY2xJKzV3bE1peENEOVRP?=
 =?utf-8?B?KzJ1NXpic3p6YnFGd1JQMGY5VGJwYko0TjZTT0h2OTRWcGE2dThHMWI3M3du?=
 =?utf-8?B?aDE5ZVQ3LzVaSmQ1YkROOFoyMEh1RE1RUHpucHQ3YUhkWEYra1NCMDZZbS85?=
 =?utf-8?B?ZW52U3pFZUE0OUoydHpTV2sxNjF4QjEwbWdVZDlZT3hnZVRMMUNWM1RPNXNo?=
 =?utf-8?B?aUJDTGVvbjRpa1J5MTdlK0h5eHVVRlNZNGpjWDRwNEE0ZDM4OTBKc1JVWU5E?=
 =?utf-8?B?c2pWZTF0T3lUVHdQcVNoQUF4OHErNFhNZWJPM0QvcHBYc3NXSWptZ0JGZVh3?=
 =?utf-8?B?Wk1oRTI1dXpOcVpCb2NHQXdFdmNTT1dNQlRUV094VERpTmFMS0dIcXU2Nm5k?=
 =?utf-8?B?cnFjZ0xUZklab2ZhWXpWZXZPclIvNnA0Wk1pM280TU1LKzlPdGo3SEQvNi82?=
 =?utf-8?B?MXJFOGJiTGtGVnpxU3VocWlONFM0MmpJSWFTMDNVYlQvVnFieDk2V01oSHpK?=
 =?utf-8?B?T2JzZnNPeU1tY3U5SGgxTjF5Z05OWTQ0MnhMbG9hVG9JVFN3Z3VwNGRwVS9I?=
 =?utf-8?B?czlSMXVNR0FmY0YxRHBaZFcvREcwSjh2ZENqYlByRDlSRTFsSkRhZGdTaEx5?=
 =?utf-8?B?N0gyVjI1VjEwT1NORjZkb2JSaEI3TlEzQUhUTU1iSUxSYXAvMllyekM5ZlN1?=
 =?utf-8?B?ZnFZWkNsUk8ydy81RjZzLy9MOTNLdnBWS3ErenVEYW1KYUluRzVHVWRWTHow?=
 =?utf-8?B?SnB3RkN4enNZRktUZGs5Y0U4NTViMEtoSEhtQUZJaUcrWmJCU2JsVTZSeWFF?=
 =?utf-8?B?NFBXYUk3TXM5blZWbjFJa3pubW1aRHdjRFFPYm4xMnRRODhrZjdVVU5HSjhs?=
 =?utf-8?B?SnN3T3U2M0F3N05GMUxieFNhb0RqVTh6Wm5GN21sRVdKUldINXBNQ3hyRnJE?=
 =?utf-8?B?YVNUR0VZd0FubXZyZ2dEZGNpMnJzZEdVMTQ0eWNlUlIwYlVvYU9JbnVULzNL?=
 =?utf-8?B?YlZWdVNUQzBpNGlZbS9JM1BaYUp3TndrclFpK1FMalJKdG13S0t4Zm96MjNw?=
 =?utf-8?Q?Tfg9PwO/mm14mHQUgT+7ImE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abb380a-1680-4366-02f9-08dab1eb9863
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:04:26.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMSg5mYg9FFVFZLiIMQ+6zXPgegYiQgmB8j8+PQ/gzaKt/F/znhkcVQY9JfxuJ+gkSoEvBq0jQjGqSZt0gnAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3923
X-Proofpoint-ORIG-GUID: OIw7ig-XeuXP045JBmz1ayZ8T5NrAs8P
X-Proofpoint-GUID: OIw7ig-XeuXP045JBmz1ayZ8T5NrAs8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18/22 8:28 PM, Andrii Nakryiko wrote:
> Teach libbpf to not add BPF_F_MMAPABLE flag unnecessarily for ARRAY maps
> that are backing data sections, if such data sections don't expose any
> variables to user-space. Exposed variables are those that have
> STB_GLOBAL or STB_WEAK ELF binding and correspond to BTF VAR's
> BTF_VAR_GLOBAL_ALLOCATED linkage.
> 
> The overall idea is that if some data section doesn't have any variable that
> is exposed through BPF skeleton, then there is no reason to make such
> BPF array mmapable. Making BPF array mmapable is not a free no-op
> action, because BPF verifier doesn't allow users to put special objects
> (such as BPF spin locks, RB tree nodes, linked list nodes, kptrs, etc;
> anything that has a sensitive internal state that should not be modified
> arbitrarily from user space) into mmapable arrays, as there is no way to
> prevent user space from corrupting such sensitive state through direct
> memory access through memory-mapped region.
> 
> By making sure that libbpf doesn't add BPF_F_MMAPABLE flag to BPF array
> maps corresponding to data sections that only have static variables
> (which are not supposed to be visible to user space according to libbpf
> and BPF skeleton rules), users now can have spinlocks, kptrs, etc in
> either default .bss/.data sections or custom .data.* sections (assuming
> there are no global variables in such sections).
> 
> The only possible hiccup with this approach is the need to use global
> variables during BPF static linking, even if it's not intended to be
> shared with user space through BPF skeleton. To allow such scenarios,
> extend libbpf's STV_HIDDEN ELF visibility attribute handling to
> variables. Libbpf is already treating global hidden BPF subprograms as
> static subprograms and adjusts BTF accordingly to make BPF verifier
> verify such subprograms as static subprograms with preserving entire BPF
> verifier state between subprog calls. This patch teaches libbpf to treat
> global hidden variables as static ones and adjust BTF information
> accordingly as well. This allows to share variables between multiple
> object files during static linking, but still keep them internal to BPF
> program and not get them exposed through BPF skeleton.
> 
> Note, that if the user has some advanced scenario where they absolutely
> need BPF_F_MMAPABLE flag on .data/.bss/.rodata BPF array map despite
> only having static variables, they still can achieve this by forcing it
> through explicit bpf_map__set_map_flags() API.
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
