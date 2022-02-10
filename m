Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6A4B14E6
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiBJSFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 13:05:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiBJSFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 13:05:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB3101C
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 10:05:11 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AErh0d015621;
        Thu, 10 Feb 2022 10:04:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4NjgHs0KTUKkmoc6xlnQjEcU7Whj1j5Zz5IwBkFI8C0=;
 b=YHOHAZCbHAh+woydbhhcXlmn5udGYJo50RQCDbQOZ1nUA3fgg4CAdKzF87YLk9TmOATe
 buCyQvzFqddE7GKhzbWaumUDOZY+10zf1XfZoPYcFJ09BiMxPdWPXfx+66O8SSJmM0xO
 9ial44ANqHYpInTW256EjhG1ibi4jpFgwnM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e54v61hce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 10:04:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 10:04:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NchrkRSmpJFcf0IEJhS8CnV+RtgiKNWoQuTokiyEe1wn0de/YYDw/xJo8PDsblFH95kOnzZr3whCPzMwePuZcl/BlhKJCi5+1EiuG5bYvC5hsAPYU4ZKuE0SOZt9Io7+7VujT9Hr6di+zALCm6qLQzbgNRWMHfO9lnHVmQLHpyUXBEX3MtI4vkMoxmhaVB9wZde87RvfrkG1gsYQUP6HnRU0tkdUcHkpc3bgPKCI4FGGfm9wL891KI8Ul5fx24eMi2jzpYertmLrzvrNkogxgaV0VNP1GIS+bGyFvrP7wej1nJ4UOnsUGfczAD1x3Ipna4z0gVbVrzXw+e7NqZJV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NjgHs0KTUKkmoc6xlnQjEcU7Whj1j5Zz5IwBkFI8C0=;
 b=cYnbjx05H/29ujtPGqCOFqB7aGKhyX+TNjsM5Wz48XnJ3AzMrP5MaICEiZQXo8Gphd3m6CLVodv0la/YlzjP7N/T6RcTwrMXhdvn4vbGGyQ+aS59FhUCGOBtbq3CNdIY7o3g2j2NnNYBiN5WEMXT9UeGa38P8y/yHDOj8Xq4BuK9Y1ZI4rRy+pYOqv+pAfZnpYXmtTfHb0bmvYTsIZzTUjcN5JsjJTjkptzmb/mFtpJIs6/VPPWauqNBZ1ASQ4hyl1L98GOWXchpsUe4/1r66uO0ryd3XIFN60C+drwHGQCC8G84SXSEyrWtJYzHuzMI7PxziUqUq9oPNYLYV/T/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5294.namprd15.prod.outlook.com (2603:10b6:510:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 18:04:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 18:04:51 +0000
Message-ID: <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
Date:   Thu, 10 Feb 2022 10:04:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Felix Maurer <fmaurer@redhat.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
 <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f364bd0f-700c-438d-6be2-08d9ecbfd551
X-MS-TrafficTypeDiagnostic: PH0PR15MB5294:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB529489A87FE977C344DE25F4D32F9@PH0PR15MB5294.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzbcs2p2lFK6At+VVo7JHcTfb0VFt6g6S5HumlJUiHKUfbuVggS9Yl4FwaECxItwjzwKRFJyJGEYUw9R3pQ2VRe3Jdb9T9L6FJJGXEysb+Com2Wt8/dJJr4EUHm48L2IPbVL3v6Zzi9k62yo54LL5kJp/dIou7GH9xZYxGjwZAvOSu95eyDLWx9mwguju+zYERXjdk2XeXxacLORbqVRpGbPapOq3pGzRNHDvYoGNcKg1QdNNnNAT2sq42gaXZAxvJBpZbW65VPGrivbggA+jbCrq3r37KHjNB1wBiZc35+HJKvGCvsRHwNtOI0j/ZKKbtAKTUNQmeMR5SqXljZLuHi5HVWXr0ebd/UtXLnXY7aK4pBYR4wcbAW3nKgzUkVOiObghC64vv3JSB5IHyBLCZPK1RY/TQ81lpOPGtuSWY/OLsQFDmxWW/bz6iPk/tTYz63xiQJnBEBsAosQTtCqD1NIGr43+9j7oxdOYK40Z3aiRBefPBWijOOjY3pZlCDsrbhQC+NYTbE86OJ9Xix+MRatDXE/3/jZ0esConPcGknuMirKwQDWLXiE5y0yt082PZHavSzSUCulhY0tqys2oSAHe/xlTmkk2y8DO0gkKV9ktZuTM5ntKBYZ+Bu5vjNbJPub5gldoFPK0fkPqt+RPLtKFZbdwmw0A1gW7LoLoZW3+uiXqPejuuQ6+QTUQpuqpP7mqzJ0fnOv/1J+YaGiNlJovoaHAV77f2IK8HOv4aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(8936002)(31696002)(6512007)(31686004)(66556008)(66946007)(83380400001)(52116002)(36756003)(186003)(66476007)(6666004)(2616005)(508600001)(5660300002)(86362001)(316002)(38100700002)(6486002)(2906002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpGQXZHT1pWK3R3Um9XdG1vbko4YlJnVkc3aEVxd1FHS1MxMEZBUFUzZ2Vo?=
 =?utf-8?B?ak5zWlQ4ZTZFZmwxL2RFUm5OaWFNWnZZRzVmQjJqSWtaT1BNbUY2eUE4VVpk?=
 =?utf-8?B?dWdIdkQrQ0lKdFAyQ0lZYjNLNGN6QndDQ3VPblBwRGtUMXB3S1hqakkxVEhF?=
 =?utf-8?B?ejhNMlBlR3hLbDI0R2pUNGNPaklucGtLVG9ZVlU1N3pSSHVkS2d6Z0VMZEdX?=
 =?utf-8?B?UjRMWW5zZTJ4ZVV1Uk9Xb29RTFRGWWdpSDdWOVluTzRYOHRrTXRyZVlPTldE?=
 =?utf-8?B?dkk5ZXhEZlNUYVFDb0I0TmppMUQ3d0kzMXNtSmNnQkZrdXNySThWaGhVaFlR?=
 =?utf-8?B?ditVazdwNHE3RjBaVUFTMFpFZmc5MUtjRFZSNVo5MDV3NndHb3pYZ1UyUWZ2?=
 =?utf-8?B?THRiNDR5WEtnaWx4T21kbzdQcEc1ZDZ4R2orUDRnTGVPWkhHUllCVXdkRTMw?=
 =?utf-8?B?amp4UzQ0bUp0dTlaM1cyUVB4K1dxRHNkMGFkank2TTVtK210eTh1TXZRd2Jo?=
 =?utf-8?B?SGY0MVptNGt2RFVNcG4xUisyUFRZSkFFV1hJYkFMK1dzeDZOaFVoS0RkZkxy?=
 =?utf-8?B?TzJ6T1Y2cEJZYjc4cVdvdmkvRHpsSkF2K3Z1TTRJWXF6WWg4VHJzd21JTDh3?=
 =?utf-8?B?TGFHQUQyNWpXNlgxVm5DRENUN05vVy9XOVFnYjBDdkNYeG1wT1IwenpvdEc2?=
 =?utf-8?B?bFhpUjlBWXk3SElON0JvMWRJS1R0RkZwS0toS2hGdDdSMjlMZXNoMjhyVERK?=
 =?utf-8?B?d054OWZvMys0OFZuMHh1MUhTaGNZdmJGNkpFN1h2RXQ5Zk1zTktKTjNDV2lL?=
 =?utf-8?B?T3RwOHNFZzJ5aEFvakYzNEl4MytMeldrK1p1RkhBOEt0RjBXTGtkN0FZLzIw?=
 =?utf-8?B?c0xEeXV0Y1Vqb1ZpZDRwUC9BbFhRZkJLU1pENzlrOUZNWjk3d2JPTmhoMFQy?=
 =?utf-8?B?MFZoSjloYWx2ZXhaSkFXOFhMSVJDWDRqMGRLWld3MmhTK2NvejZvTHRSZit4?=
 =?utf-8?B?Q1d1ZWx6OXZXUlVVV21QMUFZaVpBNWhiTjNVN0tzSktRLzNPaW1HUTNyL2F2?=
 =?utf-8?B?MjlsSDlib1lvUG44bFhsU1hqRmNNR0o1ZzhzandtdDkraEZBeFQ3QmhCenVW?=
 =?utf-8?B?T1dBMU94YmlyZzJkNUFsOUlsS3R5RGxpTjFlOTlXS0FRTndKUzQ2c3VKOHlR?=
 =?utf-8?B?RnozckQzL25CVmlqYUhxOGpFV0lMemc0QWJ6cjNKcE5WbXBwUEV5VmIxUEJt?=
 =?utf-8?B?YzhoV29Cb3czVjF0T3FvYVZ4Yjh1bDVVTnJ2ZG13ci94bGpQenNqOGVRQnNM?=
 =?utf-8?B?VHhUaW0xTVJoTUNYUWgvR2JGUnJ5aE9DajlQeUNLVmFCUHdRaUJUaHM0VTZD?=
 =?utf-8?B?SGZkcHY4TGxvSmRudE4rRWdoaUJIakFFMjFHaExjRVBYbVlRTEI3cjZvNitk?=
 =?utf-8?B?QTRTWmlxaVpMd2NINHBOZlEvWlZGS25lNXNIczQ0WXNxeXVJSlRwaDB2NHVQ?=
 =?utf-8?B?eWZuQzZWbU93eEM5dU9TSHVabkU4UkNsN2dNOC95TzJRbnNkVmswRFlGQnBt?=
 =?utf-8?B?VllFOFJLWW4vRWNIL0RFY3F2WFBmMEZyakhSWVBTUXU0Rkc2TVJ2VVRrOXcw?=
 =?utf-8?B?UGlWRDJCNFBXbWIzQis3dlowTGx1Q0xkK0cyNktNa1lQa0Z1dVdic1RrRkM1?=
 =?utf-8?B?bzNyR1ZjcUxOcGFaSll5WUZTUkRLeUx3TVN4RkhEMWdhc2tZMDV0NzQxNVF1?=
 =?utf-8?B?cW45TGZkNWlRL0VONkhVTmRUV2VRMkxraWtOcVcrcnBPdDNBWHZBa2FGZ01v?=
 =?utf-8?B?ZXZEWHVyaUxiRXVjQ282QnJxSGVIUUpPbTN1UHVWL3lyTjNZMkVqMFR3M09V?=
 =?utf-8?B?Smk4WXZVZGFMN3VmMXlSa1BLQ09QcDNGS3ZiM0dGZ1E3WHl4Qm9LWnE3dG1h?=
 =?utf-8?B?RmJuOUxndlk0eG96ak1wZXpTMG5YUHpmZ1NnNHpMZm5EOTFBRnJ3YXlVWU5U?=
 =?utf-8?B?cHkyVmtvOFFZMUtxby9xeC8xQWtFeUVuNFh1SDI1S3ZsQXVKRnRxVDA1KzdD?=
 =?utf-8?B?ZStndVRDcTNZeEdBV3lzTkFZaERGWis0VGFldEhTNEZRczFDZTJYMmtNNEJJ?=
 =?utf-8?Q?7J+ErNnJGSTepNBeGQ+6w+XAp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f364bd0f-700c-438d-6be2-08d9ecbfd551
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 18:04:51.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3nDxfsyYVUUpiJDaTFgd38sILKcILIgpGLyXS8WnT3k/bVtZYReyHXjhDhRT3dU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5294
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 49M8q9t6t-SBO9ZjGEmYIU4VRF9H27jP
X-Proofpoint-GUID: 49M8q9t6t-SBO9ZjGEmYIU4VRF9H27jP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_08,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100095
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/10/22 7:45 AM, Felix Maurer wrote:
> On 09.02.22 18:06, Yonghong Song wrote:
>> On 2/9/22 7:55 AM, Felix Maurer wrote:
>>> If bpf_msg_push_data is called with len 0 (as it happens during
>>> selftests/bpf/test_sockmap), we do not need to do anything and can
>>> return early.
>>>
>>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
>>> error: we later called get_order(copy + len); if len was 0, copy + len
>>> was also often 0 and get_order returned some undefined value (at the
>>> moment 52). alloc_pages caught that and failed, but then
>>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
>>> probably not out of memory and actually do not need any additional
>>> memory.
>>>
>>> v2: Add bug description and Fixes tag
>>>
>>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
>>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>>
>> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
>> modified the test with length 0 in order to trigger that? If this
>> is the case, it would be great you can add such a test to the
>> test_sockmap.
> 
> I did not modify the tests to trigger that. The state of the selftests
> around that is unfortunately not very good. There is no explicit test
> with length 0 but bpf_msg_push_data is still called with length 0,
> because of what I consider to be bugs in the test. On the other hand,
> explicit tests with other lengths are sometimes not called as well. I'll
> elaborate on that in a bit.
> 
> Something easy to fix is that the tests do not check the return value of
> bpf_msg_push_data which they probably should. That may have helped find
> the problem earlier.
> 
> Now to the issue mentioned in the beginning: Only some of the BPF
> programs used in test_sockmap actually call bpf_msg_push_data. However,
> they are not always attached, just for particular scenarios:
> txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
> bpf_msg_push_data is never called. This happens for example in
> test_txmsg_push. Out of the four defined tests only one actually calls
> the helper.
> 
> But after a test, the parameters in the map are reset to 0 (instead of
> being removed). Therefore, when the maps are reused in a subsequent test
> which is one of the scenarios above, the values are present and
> bpf_msg_push_data is called, albeit with the parameters set to 0. This
> is also what triggered the wrong behavior fixed in the patch.
> 
> Unfortunately, I do not have the time to fix these issues in the test at
> the moment.

Thanks for detailed explanation. Maybe for the immediate case, can you
just fix this in the selftest,

   > Something easy to fix is that the tests do not check the return 
value of
   > bpf_msg_push_data which they probably should. That may have helped find
   > the problem earlier.

This will be enough to verify your kernel change as without it the
test will fail.

The rest of test improvements can come later.

> 
>> Acked-by: Yonghong Song <yhs@fb.com>
> 
> Thanks!
> 
