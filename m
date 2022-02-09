Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1624AEAF2
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiBIHVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 02:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiBIHVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:21:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B863C0612C3
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:21:04 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21940m3W005234;
        Tue, 8 Feb 2022 23:20:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4uHLNtmYIX5mk1ZAL9VcsTCRo9nTjXwA3CyUMiJsHYo=;
 b=o2bDHzuFLyqJJZB/EasLhR1nK4zV7g4eMkD7hGdBNWRWZFvkUtkLtHR1gdQnEgxoqAcu
 ZuoW2+AN0ZdM5mmjWUuqXVPDGq2SVj6zwucZPMFeW7NnaHHi/uT6ue3HXRIzGgLJg4h2
 OGZDmvY0yROBOm/itz0r0xHWzwcCRYiczeI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e46730rgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 23:20:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 23:20:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuxkLTncu7UkDquhO3+HvQwGaaO9j8OQCkW9oL/N3TSeFS1Vz5yiSDMtdpvHiXP9bf1X5dVyRNo5rvq4hVmJWS+GAFCdyAmVbzqPpSGNb19t1ymGtZsmgDT4u+ZIZcujjhFGUdOQQoFxZg7W3zemI7lxSkKh5JfsiZXQhNLeNSjXkIsHAowFu2lvTGgCPQUwaZ2JE5vR5cbGSFpwYFHnFSFNLYX0xXZDsEYr7KxNm1asBJ46SMgRU4svABXMCWJDKeJNh0HeIGhTRPc9IZ6uuxajel5kx8gTg3NQZreEujxCeR+THTHRxY1az4YaZLiHtgV643GrwAGzvNCRZP58Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uHLNtmYIX5mk1ZAL9VcsTCRo9nTjXwA3CyUMiJsHYo=;
 b=an4Flb+C+ePIuWpkW64CJUOYabIIh2wc1E3Jd7KxgZt6BJ7yxZxsP9hA1bcAlhqXFlTSiDYEUFSJrdmDmTUyBvp6IJxHSUxuBsoNJ8ZfxJORbQgr9mGjc27B4ZyNoK8Slxh2cwOtcuHqC9DY2dnJNSwcO0tW5vRSDPbmcRHZCQoA/xs/FjxRlxPodo4ZcrmCMtHiIjrz7HvE/aMXFpMLKpE6cw6a62n8LhRS0bc2q8EItOAyzgM9diwSmXdtL3dx+udGtLb2ahWnCIpUP/gaRixXP7RzorPpuuFpj0loE4xRQHyol00VYxapMNg7ZttPEkWMTgybKgxNrbe7WUrslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3627.namprd15.prod.outlook.com (2603:10b6:5:1fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 07:20:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 07:20:47 +0000
Message-ID: <7e7726d6-2603-4141-592c-736d2f0f9842@fb.com>
Date:   Tue, 8 Feb 2022 23:20:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next] selftest/bpf: check invalid length in
 test_xdp_update_frags
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <brouer@redhat.com>,
        <toke@redhat.com>, <lorenzo.bianconi@redhat.com>,
        <andrii@kernel.org>
References: <3e4afa0ee4976854b2f0296998fe6754a80b62e5.1644366736.git.lorenzo@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <3e4afa0ee4976854b2f0296998fe6754a80b62e5.1644366736.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:301:4a::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8361abc-8c64-4134-3c83-08d9eb9cb14c
X-MS-TrafficTypeDiagnostic: DM6PR15MB3627:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB36277CF04BA6DA7BEF9406E2D32E9@DM6PR15MB3627.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUq6fk6b/hwX5RjUptgQM1y+TcM16mE/ilGFXmN2hFKTGlGGYOZ69hoGUScYgRPBKibFoVn5RC2KPWU4w5iR0m1LQFteNhU65zEunH3l9rhmuUNavvl8PDL9oRB8wKjwQ1+gtqV+Zkqvn9tB0WzWFftDNicLWlWY99pXqjAX/cJWaLBOwUOe4OnK+yzwvCSqK9cPnRTQ+Ys95+QwhmsFmnoO1Al3aB4mHvzfB5/NLLcgaYNYrjG+ba7ImM5N9PLFyTbeqorR7NZ4EUj6IAPdudtKbcQChepYRkcX4QXoYXQE9T/vUXRMWN2WYZpiU5LNK1rsaZWJ6jHebKwyTSA7dueq+bFpmfOn4F2zTU99gSggY+ZmrvRpqJ6Q8gGyvxDcSd3wI3oOdiTIuLL++aqFy5toSzDt3NYG+N0zifR1xt/ECNxHYLAB9L4e7d6Tm+TDUzLOEmJ+7B5/bv51/O1JM6XvZMoXcxq903GeNajgTMc2RkJ3j/0CAGwPO+Z7NIXpT1ZywTqwf2Sbe8D7QUNlngHnEmzKMA1NS0eVzJbqoAm8uDyL+ZZCuydiCwxkhjHREODaadzRgIzRdHl/vk9Fc+Ekcm9EYb/YNXHDyXfJdLvhGJlFV1r7HZFcitIuyEGRlp+DDFAlbYjNUotAMmE99csYc1+QLW/mtXHYNv3Dn6Xk4jjj143ZU+D6CKaAgzTSGz9htSdKm5CjPLZw0E6mSanz8+VSfWp9de8NVg1ePA9Wiw4XvgJyZx9CCnelKWla
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(31686004)(66556008)(8936002)(66946007)(66476007)(36756003)(558084003)(316002)(186003)(8676002)(2616005)(4326008)(83380400001)(508600001)(6506007)(6512007)(31696002)(53546011)(86362001)(52116002)(5660300002)(2906002)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG50OW5sa1FiaFNVME9vY3E2eE02VzBaZlE4aEhKMXI0QzJTNFJmcVFYMy9o?=
 =?utf-8?B?blVNMGx0OU5ML2Zva1ZWcEFvVlViRlBaNTRsbTBLNnczYXlzeGZ6dXlJY2NM?=
 =?utf-8?B?R3B6QndjNUdQYmNFTUxmTHRQVElWN1cwdWFwM2lickczdlBWZ0NWT2F6dmU5?=
 =?utf-8?B?MUdiaUE0b1B4aUd1Q3FiVUdlTEF2OU5OY1NIS3c5Qk5MM1lDVXVLZDhYaE9n?=
 =?utf-8?B?N0NRRDN2azJoakVXNWZEUXMzRGVFVUVBbzhON0pGVmlHeUVKTUFPY1NDWWRh?=
 =?utf-8?B?Y1RwdXdNVGhjeDd2WVJEU0F2WEtMajcwNndLb2VMWXJ1TkJkZ2JPVnlUR2xB?=
 =?utf-8?B?dDNFbzc1aHkxZkh5M2J5dXFOR2o5M3VpQU5FbFJnQmhCRFBodldiSS9KUHZL?=
 =?utf-8?B?Z0FvZEFWcXpFYkM2VlNkZjNIRkgwOG1OTlFvV2NRbmwyUlJVK1doNXZuZEJC?=
 =?utf-8?B?cG54eWhReGtjaTVGeEpLUDNHQVl4Q2RaNGd2c0ZMTm56ZDY1Qlh4KzBSakxS?=
 =?utf-8?B?MkVnZ092R3dmd21janlXSHVCK1Roa1hydGNFMDVVMXY5Y243S3p6dk1kQldS?=
 =?utf-8?B?QWZDaGZIRVZXb0lKUmRZYUk1cmUxSVkrcEtwR29Sak96dk9uYnEyL2dra2ww?=
 =?utf-8?B?S3JIK3ZnSm5tU0xWM3pVc201bDZwOFZJSkRWd2JzRExWeGJnQW8zQ1V0dzhq?=
 =?utf-8?B?VlhMRmsySkwwK1I2TmdhQjZlYi9WZ0VROVJNSFhJc3Y3U3Y3bmlUS3VndWxo?=
 =?utf-8?B?dTgzN0ppYnMyRXFpVFRlMHhKMkVLdHd5Mk5naVFsamNEZWIweGFyckhmZFpI?=
 =?utf-8?B?bFlmZDBOUk1hMlBtYnhmdWxCSXBsbGpKK1lKZ291aWxpR1ZVeHY4RytBdjBV?=
 =?utf-8?B?NUVTRXUyQnY5c1k2ME9HTXA1VUo0cXEzNENMeFJIQ0d3SDBRZytiRWVzRXFx?=
 =?utf-8?B?NTE3MWhvQTE5WFRtc2I1c2JsTWhwQmdOMWcwNVZnQ3ovQTZNWHJHVE0zR2ZU?=
 =?utf-8?B?WDJvWEN2d0FCdUZLM2VXYXM0Zjcxek00cFJPMzF3aEh6NXNIVnRUT0xmSVNO?=
 =?utf-8?B?N1hCM3hFQVB4WGdZdnpUSEpYUG5uRWJEbmxIY0Z4NWxRVUd2VEVhdDk4R2c2?=
 =?utf-8?B?RzdwcWZaQzExb2kxelpNNmdmNlprWXNtL0IxWkVyT1IwRHl0YTA5L3B1RXVl?=
 =?utf-8?B?MlczNFdvanoxbHpTWjlrTVhtRGF5dkE1U21HRDJPTjNzbE1rMU5QWHUxN2xJ?=
 =?utf-8?B?elhNRDRrODNrLzUyaXB4ZzIwTHd6ZENKanN5RFVhcy9oalJSbjg3dFJPZXhS?=
 =?utf-8?B?aTdzZEExdFlubm1YYnQyTVY0UWd2VWcyeEVKUHRENXFBTjFxM2MvOFVYYVhz?=
 =?utf-8?B?VHBkL1RpUWd5YTBqWS9IL1c1OVBTbTlzc0s4eGhsSnZDejVJaXYzVGE3OGFs?=
 =?utf-8?B?eG5vaGZDS0RCeHZGanlWbEZEanBmd2owdUcyRTc5bVFHcTdTOTNjcHZaM2hx?=
 =?utf-8?B?SWpUcUx5VEtaTktGV2FxZExxZVBFR0lwVi9JL2xsUVdMc3IyemQxa0s5UEtU?=
 =?utf-8?B?N1l1em5ySjhqMkdUY2todUFmRVdpVGptSEJnZ3dhY210VURMTVNNU3BDc0t3?=
 =?utf-8?B?TW04aStXdENlaGRyckFSOC9ra2lNSzgyY3VtM1FMYWl3Q0dscWJZOHlJNER3?=
 =?utf-8?B?ODhZRityWXJuTTVRT1c5RE9oWVl3c21QdlMwVXcyQS9LWlJ1d01VRURGZDdm?=
 =?utf-8?B?Z2szbXdwWFBwOTVtVmliUEhZZU12V3Y5RTFpc1Z6cnk0d2lLUXBTSUE5djVF?=
 =?utf-8?B?Y3RhSEFTelFJQy9PNlFzaVA3MktScG1VYzY2ODJWcTAxZ2Jkb2xvbk0wZkNs?=
 =?utf-8?B?dnM1b2szYVpIU3UyczdtRThTS0RzeUI3UHM5YXZRbkFwYm55SHhHTGRubDVR?=
 =?utf-8?B?bjIzTk5NQllyS0VyUmxtdGpocXVGK1l3QWVqeTRwTytnUHpCOW5ud3VuaFFE?=
 =?utf-8?B?ZjEvRUhWMFBvaFR1QTU3MHNzcXJsTGliSkpGUThES3lKVVo5ZW16ampUU0Fi?=
 =?utf-8?B?dWhNanJSUm9IZG9FVHpPbitWZkl5aWM1NzlRSDVQbmhvczYrOUlUNHVhNVlF?=
 =?utf-8?B?N0E5UWFkSGVXWEg3bWZNQ3dIRWMzdUt5TlZRVXB0MHlydUtTaXczZXJibXFi?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8361abc-8c64-4134-3c83-08d9eb9cb14c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:20:47.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nOwjn9PWJEhDrtyCFBwO6TsDOaXSXVNhdFlxj3QNuPRScU78PXEEvcwy2IL/iGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3627
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Y7mDphwh0N72nCxk_jKRXKuKbkhtznlP
X-Proofpoint-ORIG-GUID: Y7mDphwh0N72nCxk_jKRXKuKbkhtznlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_03,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=692 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090050
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



On 2/8/22 4:35 PM, Lorenzo Bianconi wrote:
> Update test_xdp_update_frags adding a test for a buffer size
> set to (MAX_SKB_FRAGS + 2) * PAGE_SIZE. The kernel is supposed
> to return -ENOMEM.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
