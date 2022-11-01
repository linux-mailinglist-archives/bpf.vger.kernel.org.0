Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0E615006
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 18:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKARI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKARIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 13:08:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41F25F4
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 10:08:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1H2acJ032172;
        Tue, 1 Nov 2022 17:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SOyfq+nNpR26Xc9gpZmE7MAqVXjRre3rz+xeTlf67zo=;
 b=v4rcMmw5NhfgesypcXVIqIFT0J5pCnTdfyj76b5ShWffOKB1A4lbQ4oVkMfDzxFgHMyf
 URpybRn9n3n63EuAr+PHuB4BipUJ6hQ/wZ2Tdh4mNYhH9nHo29JmvEilgweJWbI4S1lC
 925lABmT41N0C5mnwSePCbxVL/eAoEdsd/SoOmankSybn6W14pw3RiiD1o2NeVf4W0x/
 PyJ1kTIWpDJgMmIyCu533If/72ubqj0vOTucWhztidJaBGIvPYZgRGWXhIeGhL81bFZm
 c44No4vt6f+C3KNtQVqYLv+omXgydFmTAvrHVZmXjmqmqqfQKaxDz5ySvVL/Y4Zdlje9 Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd72fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 17:08:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1FbqFB014250;
        Tue, 1 Nov 2022 17:08:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmapxn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 17:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5mZeCSK3f8EObRE9lh2VBetintxEvN8ZhmeVCtLonCzQ+qc+cS69/ost2FHHF1Vntj+0B8BsTIhW86up2BMLFx2Owg720vB5AjNbhBdeOqMtFn2YuZFJwImCuJ+O6sRsshogzytXsUf35zl0LkV6jF32KwJT8jIuyXBMnAurmxONJPub8qzgSyanpgghmOzO3RI78tPgB8TEucrdVR049vjm+Aj2MBXqlH7ZvAxW2G5bl2M7f0ex3yv1iW6DucrfE6ubJZS6GsmR1i2IveiBBgWyYUuYkmCZ8B5nNUpd2LBtomWJxZWw/0oguVbiBgtCbWg01nGG1MxPO+Sao9D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOyfq+nNpR26Xc9gpZmE7MAqVXjRre3rz+xeTlf67zo=;
 b=gE87JH9Z7+oIn+KU1/rVC76t5gNbzheQ8s+qylBxS9lAL+1uXKdGu1VKFzvDBWghwxVZFd1KwBenO6nAgjBGDDxnpIi5ymxVsqRxMQbEqZTi2tz3h8zRL2aJkvVWlYHKOr03PKeRw75cseHPAYmHujqjbvRN/9z9sl0ezWfUYw9VY2x4ReTV9gG1b09BPvGVSJpZ/t1HNhsuHNVHo71+sZYV2vrJbZsmjZXmpToaDwwTNSN1DuE4otWEPGP/q4DwY+Jmggv/3u7BeKSKHJj/OFHmqC76qvmXB9m9lG/I0EoCkoAlG8tcCbsiYlcrYzGZFdApV1u03sfVzn28oikHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOyfq+nNpR26Xc9gpZmE7MAqVXjRre3rz+xeTlf67zo=;
 b=hLIfvjlOveMRoqz76TOsvpm7RbevYS4m+4CTJL68a1Jqm5rRXio5R/xmqqfzhrtyHqFKBag+UwzOCk3brsJdqrpR+UT8LwjEycCkwxKD2l78+2i69twFRDgp4abtdlrtOywCR/fKRv2nA67YHt8aFriXyOGZakFCp6TEtYIdSxY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 17:08:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:08:22 +0000
Subject: Re: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone
 forward declarations
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-2-eddyz87@gmail.com>
 <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
 <264553ab5b53d22442ecb13725da905be8530c21.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <c70549d8-f9c7-636b-7e4c-2b3e918978ec@oracle.com>
Date:   Tue, 1 Nov 2022 17:08:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <264553ab5b53d22442ecb13725da905be8530c21.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7bd5e8-f4cc-4c68-cb24-08dabc2bae73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYbNN9dq3hiybSmwboEiUkjMQUdyIb5MUuA4VuEKWz1lp6eC3/USxRjzfOMkK/Uq0VE8oswloQlc1+hogloi7Z8Q91A5LqinwX0B1BPm+k7iXPPamww5IlFMiZcMlLJmIChau2nTQHVSmtAJKdth8OlBc6R08vsdQaKNKDM6eD2dnod/SrhhvICM2e1zSLEddD9vBAnawpDlcz4HWNoTsPYydSNObRyJmP52QR5UHcXkz9BJe4LinvCjMKU2r2MiCUwGalIP6HH9EY1cRDnLRa8ApfRDLs/8ThG0f55L4oOXm/QhYhh3j+VuS/VO3P6IWHXnrCb9fEWyz6shGjomBaMtHdYFO+j5vV6SX+STJSu+x3n0oTIcw976ukUgm/8y9JJ+/kKb8ensiePY3SHP1EzCopaee7RGfDsRBRvGpFkVWjAXtXJz0GxW8b7VqEjWhzMqJbt+hksXQWW7LAVB6dnPKvvVeqrKOyLF9j/6nPXzUhBFJ4eY3fl9Onpp8L3qETHAZ+gCtzWyWqpd/tEEWJMrbsm9DOk52MHGmGJiYNz1U2AClLd+jidWaVE62frVgWJWwgjOw1FfwKlZ+VIKaqLix5qTz/2hRPmdmq92KnSJALysbzYSGsgon5Yz6S6T+N+tL6werSUrS3CJWYhqxfoECiWUfI60TgV5tKlI2IRnCIP9ScvxBrJ/e3V6mlFmqUoeKanovamtQBJwxlKB8sbxA2ij8r+VEkZbzgGPGlbTbrBE5eKKgEJWQeHRweACbUR+RthAQs3vNT2cYhUQ8SR5065DX6QbcoGvAj3UsmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(44832011)(83380400001)(4001150100001)(2906002)(2616005)(31686004)(5660300002)(186003)(6486002)(41300700001)(6512007)(86362001)(31696002)(110136005)(316002)(38100700002)(478600001)(66476007)(66556008)(66946007)(8676002)(8936002)(36756003)(6666004)(6506007)(53546011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHo0aWNzcWM1WFpNSzdDa0kxZ3UvcGM5R3NmR3JDbE95R1BmaW51L2ExeDZL?=
 =?utf-8?B?MDhtT2pBSDFQWjFEOGYzVUNKS29LMUNsL24yVTR4T1NzL09Ec3I5Y1dxM2E4?=
 =?utf-8?B?eXNzTDRGQjBSdW9ONThnNS9KR2tXYVB6RGNiOHVQTGJWVGk3a3BUUjZIVlhy?=
 =?utf-8?B?aERFOFhTS09oZ0xDVGtpZWhRUktFMXVORmxsaml4T24zQzhuUWxsSDVnb1ps?=
 =?utf-8?B?bWx5eUthWlNDblVuOHI2OFJ5L1hISWliQlg2TEFTejRUcWw5NzFVeFBHRG1p?=
 =?utf-8?B?QzB2UEY4eit1QXhUaFpqWEdQbTUvTWM1OWNXWGlEb2dxbkhVN2Y4dHlac21S?=
 =?utf-8?B?d3JvYzE4QnNqVERtY3JCbkx0SUJBQWVVRGpFSjhxYUZYeDJGenlHTXRDRlVH?=
 =?utf-8?B?bS9sV1lmcTBaeTJsU0VuMGR6SXI3U2V5Z1c3Rm9yODhML0V5eGxkaW5OR2NS?=
 =?utf-8?B?NTduSFdnS1BLMmJuc1ZLampyeGg0cjlVbEZFeW5pNU1jRkhyMWJmUGkrYW8v?=
 =?utf-8?B?V056bWk3MGs0c2h3SmswTU8zVmFESW1pazNyMXU4cDRiVUFxVHV5OGxldStV?=
 =?utf-8?B?am5vUnJVVmFPdDJuS0s4M3ZvQlRMUkRVeHUyQVVWUSt2a1hxTVdYUlhNVWZU?=
 =?utf-8?B?VG1WeTNZQzc2T05kdmhScVJvY001MUxNSDBWVk1PUnpicXJ2TnpaYjBtRzM1?=
 =?utf-8?B?b3B6TlJDdHFqWlJ2MDRJdzFBWkgyNng0Ry9McnhIcFpWOFRyOU9iTE53UVJZ?=
 =?utf-8?B?eHUwK2hrOXREdnNZVWtCZ3RoemxKS2F1eHBqOHR0SjdzR00yeC9LQjBKbXJh?=
 =?utf-8?B?SEw2R1VwRFFwS1dkYzZwaDdQdExwd2dFcE02NEpGVnhsUllqTmFzM2dTY3pR?=
 =?utf-8?B?MENOdFdyVHlKMnlVOWhISXl1Vk1jY0diTDJQZFAzVEtVOTc0TDlXcXlWM3F2?=
 =?utf-8?B?MjJUUHJqaGF0dEV4WHNqU04zQmY2cmlHR0s4Vk5Ra08yTHlLV2pEL3ErRXRK?=
 =?utf-8?B?OEVtbEY3bWZzMTVLUDIxOFNzY012ZjlsRFNVVVVQZDdQRGQrQzVlTEg0bFBo?=
 =?utf-8?B?NFNYclYxcXpPQUNnak1TbDVaeWg2SVpqTkFZOHlocHZQWkZtNjlobFVJQTNp?=
 =?utf-8?B?RVUwMzZSTE9kR0tKcURyb0Z2THgwZWFGRWlPaHRMemJwbEgxdFhKMG12ODh0?=
 =?utf-8?B?Ylk4TkY1SG9keVhpU2x0QkVhYWVmSE5UdUdOaCtDYkJyQmtoOEtwdVhwdGh3?=
 =?utf-8?B?YURERjlRakVJWEgveGxpRVBrSTZTbDhvSWd5azM0bUp0RVc5YVp1VVhoNHhY?=
 =?utf-8?B?Y2tGRmErSnJhNENWVUtiWDNQRDVvNUVMcFk1R2lLT29Uakc5V0lYR09INlpZ?=
 =?utf-8?B?WXY0UlZid2FTUjFyUXlONnZCQ1lBMk5NVzR3dS8zcmRqUVp1RGx0emluMEts?=
 =?utf-8?B?VzNRUk43Q2M5dGNSdEwvTE82SUJjV1Y2ZDBraEZjVS9VRzBRbUpmbjhiTG9V?=
 =?utf-8?B?YThwT1J0c2VBaUR5ZUo2QlpTYmRISUYxWXFGdEZubE12OHpBN3MwNWlZeTRM?=
 =?utf-8?B?N3MxUS9aU1IwZk5kc1FkVlpGWk1qM0UyaGZaZ1RzM2FmZURVdDdRT2hFM3VD?=
 =?utf-8?B?OGpmQ2hGRm9MdVhKeGYyTUlqdS9XblptdFF5QmxQbkVRZm9LeHZRRDZhaFF0?=
 =?utf-8?B?NmFNa08wUDdrclk5U3NCT2ZJSExOck5WQXQ2VFdHRFR3STd5NU1mMU9adFlo?=
 =?utf-8?B?cDFOMDBINjlOcnZuNlcvUEFaUzkxOTdEWlpKTzFGMmxhOXh2dWRjK1h4Q2th?=
 =?utf-8?B?N0djczdIUTRWM1dsMGhhWDloNXFqZ0pydW02amdsVmJJbnJRWW52ODEzS2FR?=
 =?utf-8?B?aHlTaWwrUHBiTWRrd0ZOd3h5aXE4elRUZ1NIVElEZXpKNmVhNWgxc1lKdWIr?=
 =?utf-8?B?MWQrcndGSnc4TUtCeThYR0pjNjU4RmdJcUdTK29OSGZaWjZuMVRxdDIyQlhQ?=
 =?utf-8?B?OHArNkM0SmkrS0xoVWVGNm9DcEhJWTRReUp3TjB0dldDL3FjMk1wOGFXdDhi?=
 =?utf-8?B?VGF6K1NzTDdiZC84SmlObDV6R1MxRWRDb2dqTllCd3hUQnBrak1KZlUvRTcv?=
 =?utf-8?B?NVBmbHVmRDJ0K3NwZEIvMnhnL0NIVThUT1RSczhtWk5HV1N5Y2QxanBpYVFZ?=
 =?utf-8?Q?snFedZax8+U3qGocQu6Dy2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7bd5e8-f4cc-4c68-cb24-08dabc2bae73
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 17:08:22.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ouc61NEnLqrVPJiY1OvF/RqsMtPHSrXgO35c60SMZBwCjb6hFBTkvF90G8kqYtQ2KnBtvzAEJ7gJoofQSTnKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010127
X-Proofpoint-ORIG-GUID: gjElFg3_ivwdXYXPrac8-8RkFM_j0zwp
X-Proofpoint-GUID: gjElFg3_ivwdXYXPrac8-8RkFM_j0zwp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/10/2022 15:49, Eduard Zingerman wrote:
> On Thu, 2022-10-27 at 15:07 -0700, Andrii Nakryiko wrote:
>> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> [...] 
>>> +
>>> +/*
>>> + * Collect a `name_off_map` that maps type names to type ids for all
>>> + * canonical structs and unions. If the same name is shared by several
>>> + * canonical types use a special value 0 to indicate this fact.
>>> + */
>>> +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct hashmap *names_map)
>>> +{
>>> +       int i, err = 0;
>>> +       __u32 type_id, collision_id;
>>> +       __u16 kind;
>>> +       struct btf_type *t;
>>> +
>>> +       for (i = 0; i < d->btf->nr_types; i++) {
>>> +               type_id = d->btf->start_id + i;
>>> +               t = btf_type_by_id(d->btf, type_id);
>>> +               kind = btf_kind(t);
>>> +
>>> +               if (kind != BTF_KIND_STRUCT && kind != BTF_KIND_UNION)
>>> +                       continue;
>>
>> let's also do ENUM FWD resolution. ENUM FWD is just ENUM with vlen=0
> 
> Interestingly this is necessary only for mixed enum / enum64 case.
> Forward enum declarations are resolved by bpf/btf.c:btf_dedup_prim_type:
>

Ah, great catch! A forward can look like an enum to one CU but another CU can
specify values that make it an enum64.

> 	case BTF_KIND_ENUM:
> 		h = btf_hash_enum(t);
> 		for_each_dedup_cand(d, hash_entry, h) {
> 			cand_id = (__u32)(long)hash_entry->value;
> 			cand = btf_type_by_id(d->btf, cand_id);
> 			if (btf_equal_enum(t, cand)) {
> 				new_id = cand_id;
> 				break;
> 			}
> 			if (btf_compat_enum(t, cand)) {
> 				if (btf_is_enum_fwd(t)) {
> 					/* resolve fwd to full enum */
> 					new_id = cand_id;
> 					break;
> 				}
> 				/* resolve canonical enum fwd to full enum */
> 				d->map[cand_id] = type_id;
> 			}
> 		}
> 		break;
>     // ... similar logic for ENUM64 ...
> 
> - btf_hash_enum ignores vlen when hashing;
> - btf_compat_enum compares only names and sizes.
> 
> So, if forward and main declaration kinds match (either BTF_KIND_ENUM
> or BTF_KIND_ENUM64) the forward declaration would be removed. But if
> the kinds are different the forward declaration would remain. E.g.:
> 
> CU #1:
> enum foo;
> enum foo *a;
> 
> CU #2:
> enum foo { x = 0xfffffffff };
> enum foo *b;
> 
> BTF:
> [1] ENUM64 'foo' encoding=UNSIGNED size=8 vlen=1
> 	'x' val=68719476735ULL
> [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [3] PTR '(anon)' type_id=1
> [4] ENUM 'foo' encoding=UNSIGNED size=4 vlen=0
> [5] PTR '(anon)' type_id=4
> 
> BTF_KIND_FWDs are unified during btf_dedup_struct_types but enum
> forward declarations are not. So it would be incorrect to add enum
> forward declaration unification logic to btf_dedup_resolve_fwds,
> because the following case would not be covered:
> 
> CU #1:
> enum foo;
> struct s { enum foo *a; } *a;
> 
> CU #2:
> enum foo { x = 0xfffffffff };
> struct s { enum foo *a; } *b;
> 
> Currently STRUCTs 's' are not de-duplicated.
> 

What if CU#1 is in base BTF and CU#2 in split module BTF? I think we'd explicitly
want to avoid deduping "struct s" then since we can't be sure that it is the
same enum they are pointing at.  That's the logic we employ for structs at 
least, based upon the rationale that we can't feed back knowledge of types
from module to kernel BTF since the latter is now fixed (Andrii, do correct me
if I have this wrong). In such a case the enum is no longer standalone; it
serves the purpose of allowing us to define a pointer to a module-specific
type. We recently found some examples of this sort of thing with structs,
where the struct was defined in module BTF, making dedup fail for some core
kernel data types, but the problem was restricted to modules which _did_
define the type so wasn't a major driver of dedup failures. Not sure if
there's many (any?) enum cases of this in practice.

I suppose if we could guarantee the dedup happened within the same object
(kernel or module) we could relax this constraint though?

Alan
