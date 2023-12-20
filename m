Return-Path: <bpf+bounces-18400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06481A5EC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9318B20D6B
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C747764;
	Wed, 20 Dec 2023 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K0T+J/9B"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6041206;
	Wed, 20 Dec 2023 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNNmrYy8RUtaL+T+QoNchFjmXYuFy9H0nZvk7dMNmnoQMxBdwTs5FrX7mTnlDMhyunF6LvtucQbrXMONkfkBuQbtMP/fNWcUXHeU/SY/GpxadmWM9qp3UjbDj3v6b5e/SYFxix5MX9r+G0TBSUv8u/NQOJ2tkHZ6mxY+yZA/Qv5xR7qc+pTW1kHr1g8z+TTt5U9E6YPimY/5I/lBWCctrIN8gp0jdQSWw771fTj0ymijnpvbVWT97Jlh/3rkoXtgj4sHcn5zZ/gkFrq4yjRjZel0uL2uSv+IKd8EoG3Lb1LDqxIym6u5FiW+fTo8ob8sE2Kc4roT9EO6oxj6WggNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqwM6XaAPeW0lW2l3BQ5Gd4/T7DElE3UiNwDLLAhe88=;
 b=huIij99nw6kSmi4T8riQAGUDNL+Dp1Dr0OdI4On0zc+rDpFcjJT624Q48BJwPTbeA6VvpYHNtgLaw4V3pQlh/sLNJ+hymtgFl3QJWCi0ZxP50ef5iYELMtYXwP4/Aay2JdJny57O1CjACzs4bORBco7ZYmR7M3S4us5nR8shk3djx0AmIG7FxGFG+OqeYUBpw/4WrYbmaPagjFviiUHUlzZLgjhJsEZ6cmSO4dUbv/g52OFN/uBLaw74S/jKXzHy+JoYaz9aeneBQkKEANWZ+GIExG/ifC1DILi+WTMmopCxgh5odSQgbPXrjMaOnQaGlHHAE6TXpeVrjfTDC/qr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqwM6XaAPeW0lW2l3BQ5Gd4/T7DElE3UiNwDLLAhe88=;
 b=K0T+J/9B0bX/UluXVwPU3jTHXvkIcqCk3kP4vjn4hDNc2IeT2G2CrjXZ5wP7daEb+dJDHPFcboUvXGFPT8BfiD5Lcohkhq2i0U7XCnlnZMr9qiT+nAiaAwXj2ekoEGOnfIGQPR4MMVVPMGVkfpiKFrTmOjkUALgmatm7FlYVMAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.41; Wed, 20 Dec 2023 17:04:27 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Wed, 20 Dec 2023
 17:04:27 +0000
Message-ID: <e24ad563-f814-490f-8659-af6ff15cdbc0@amd.com>
Date: Wed, 20 Dec 2023 09:04:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>, Chandan Kumar Rout <chandanx.rout@intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
 <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
 <ZYKypxfcfwTjZQ8w@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <ZYKypxfcfwTjZQ8w@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:510:323::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4242be-cb71-4c33-8a74-08dc017db98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Be56hil+5UuIi2mgqax2JHavZ+sAR077VJtyrE2oHWpzOiaKmC3WTGnUMVx5zjkiXbSoEY0Lf/HOebc/rSE7BRb/PwJlHZFDbZhgKoyOh6DWbBQkbUMsw5mZm0H3DZo3tuulbcAQdamMQ5MtVpN6Qgjiv7j1s/K5hT+YXfxJts1dS1gYDvam9cminBVqT2vOvaAFFHVjTGLoSRv9FvAfKwL2dinFYhRQRnP1VqCq5A7xVOGHpRH5ckAujx8ocQRtIjE/YhZg5NjX/pk5R3W8GTmNIIdLRNRnREifKTqMmsZ0uo6VQN4LpKyDlnIRZ7CanNSeXJE/g2Br1gRRepbIq+OxxdLyPSo6moGWcKrxOAaA0a8wO46uPHPids82zxr8ban7S4vjxdqlKrX703eXVYWgZpGKi6q03mu54X5X9Q8Z/rOokyLhsfrtMKdXbhXcBC11mlX/eV2DsLMqNzkyNvr0DhaVBsnrXI8TR3T5Wsk1B2Tg8sCM8Vt9O0qt4DTbWanO2LpZ/uZ1Rb4k7mzG5ONavN/g4HtLEvFi5vSYYOY7vvmKO2TeUnpijaLmeggpcRBXAK/IcwbGulLEpYfLxlP8e9KNY5h0Q9SLaD2BMPnike+lsgXn4gYRXGtsCGEvgVO1XOkk4tl0ELCdGArYhTbyEzPc3MOET0QtgIcDqNpiF8KwwWfrTgwpKjgw4QQu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(31686004)(38100700002)(86362001)(66946007)(2906002)(66556008)(31696002)(8936002)(8676002)(7416002)(5660300002)(316002)(54906003)(66476007)(478600001)(6506007)(53546011)(6512007)(6666004)(6486002)(2616005)(6916009)(36756003)(41300700001)(4326008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RytFNE1vTURvY2NlK0ZDQ2xUS0dFbWpuaHptZnFKR2VoRENSZTNDZXY0dS9U?=
 =?utf-8?B?OU9Talowdy9RL3dOd1JxcUdRRmNWbXNXaEJoWVR2bWFyVUd5MURtUDR0N1JH?=
 =?utf-8?B?cjJBNjl3OUJBa2xCSUJyeWZqenhibHV5UXBoYUdMbjVVUTRiOW1qUHZhdlRr?=
 =?utf-8?B?dnJHTjRFWlVKRFBTK01COHFVS1ZUZkNKcU95Z0JSNDlaWVQ3cjBXa0dWZnNQ?=
 =?utf-8?B?STdOQ1lqQldSNVBoSG9QY2RBc21FQ1NhMkd0Yzg3akNqRXRzVUxqQk5WdGVM?=
 =?utf-8?B?UTlsSWEvdXBST3h0TTZMTUFwQ0gxUG5FYjVQc09OOCtjVFMvdnJYZDdlZWRN?=
 =?utf-8?B?djRwTnBTcUk5ajFjR3c5WHAvUzBtWFR6VG9EazkwNXp3Uk1DcllxZVljc05T?=
 =?utf-8?B?NkgwVzhsLzFQeEI1TzU2enlmUnd0VkZlODVOTjE1NVdLYnA2bzFzQU5UdVV3?=
 =?utf-8?B?M1lNN1RTTWFtS1NvcEFUZTU4dzZneWRRVjRaNWY3Q2k4Nkh5Yk05czkxWWJp?=
 =?utf-8?B?TkUxOFRuQ1FwU1h5dHBEeEg1NCtjYzVsdEVydENOZ3RCM1FkR1h3NXM2Ykhr?=
 =?utf-8?B?eGVmRjl3SXA1cTJKQnVLSjRnVGsxNGhjSnlpWHV6K1lwSHpQa2V4Y2lTU1Nx?=
 =?utf-8?B?RUFyYVRQbWlMRG1TVHVWUnhSYkJaZ1AxWkg2cTZpYStFMm5BRDYwNXl1R3BH?=
 =?utf-8?B?SHY1dUZoekhBb3VGQ2RpMjVqM1VaSFBYdVFlVWJIeCttQ2dKQ1ZHWWw1NkxL?=
 =?utf-8?B?Nmk1a2dqSjJGakhtWkdHbTNhanZlL1RueVlIc0liNTlWMkNJRExzYWlPNUxV?=
 =?utf-8?B?Sk1IcWZPU3BoZkZkZTdhQ25Ua2RmRnc5S20wbU8vRTcrc09GZDRiV1dCRUxN?=
 =?utf-8?B?NllZeTdLRnJGMXVJeFpIdEtHcUZhR3M0d0lDNlJ1QUdpU01tRFFrbGpnOUJE?=
 =?utf-8?B?OU14VmtsQmVvdXI2aFlVUWhmemJrMGRHUzVnWjh3NHNmVUR4Q1JGQjYxb3FV?=
 =?utf-8?B?cU9WZ1VjNTJEeHl6YjhMeFdsa2lmWlN4Kytjb3NkSGFrZGFSZmF6YmZkeExD?=
 =?utf-8?B?N2hvOUhIaUZnSXErbUl4WjFMS3pBelhJZ0NWTFlSRnRPWVJiUW9MZHVlM1RU?=
 =?utf-8?B?VlJtMlNEK0h0ZWRYckFxemZRcWZmZEVleURrdDFjcWVhNzQzQktiVmZueDVQ?=
 =?utf-8?B?RXA0NTlrWXJBbFZ4N3o5RXczQkQ3N3BLOUVOWnpZS2l5MUFvQmorVlRwYnRk?=
 =?utf-8?B?ZjZEQVJyTmNTTk1QOEFGendaTzMzeWhjMnkyZjlXL1dOdUpQZGwrNXBnVmFi?=
 =?utf-8?B?Y3B2WTg3Y2dGVUtlNXFpeE5LZmhQMkN5VUtHbE4zbG8vdC9wUVBPdEVtK1dS?=
 =?utf-8?B?VkhSZFlRL1hsVDRWK0tMd1NOcUF6SDBMK3R5SHdEWnZlRTlkZk41WHRTb0du?=
 =?utf-8?B?NkFhaHZwSlg2eFNnR1ZZSkgrQWtTTmkxL1piTVpEa3p1VGdsUU9RRjB3b3Bt?=
 =?utf-8?B?U2pjMitMRXZtUVo3eFpQdTByZHBVWmRaTXJKVklnbllBM1ovdXhGWXJodTM4?=
 =?utf-8?B?L1pHRGprbXYwRjJEdWh4SS81Mk1SZkpodFNhTWpqZUZpK3l6d0R4dTk1cjdl?=
 =?utf-8?B?c0NtL2xEeWlacTZKZDZIOEpsVEltclFmckJkeEd6VkdZMzh1VHBFQnRMNXpB?=
 =?utf-8?B?UXp2MG1HSDlBYnhqajBPWHJPRmt3UjJPNzBrcVpVdndXamliS0tBUlJlM3dX?=
 =?utf-8?B?VWVBc1ZramthN3l6cVo4TVpQNE5FSGt2ZTZQQyszNUxDSHMrUkxlblV5V2ZK?=
 =?utf-8?B?R3pIOXVyWmt2ZUxMNkhLMktVWjRzUTZvRHdheU9VRTRsS284b05tV0o5QUc2?=
 =?utf-8?B?eExWUTZuSzFPZnJ5c09XOHY3dkZRMEFyY1Z4ZjZQOWFFZVBldDUrNjg4L3RP?=
 =?utf-8?B?cUpxcTR2S2xaajJWcHpjdnhRejdiUnorMHZ1d0ZXdXB5WjNZeEs3WjFIY09z?=
 =?utf-8?B?Ukhlb1VSSjZCVS9qQnoxZExGZlFtOFExN3p5dWE1bHpwbHhVRGZzZzVsTlU2?=
 =?utf-8?B?dHRoM0hDNzcrWlRiRFNHcElSV0dISmlCT3lTUXpnZ25xZWQ2SnE4alhUdXY1?=
 =?utf-8?Q?IY40B+/ZOum11FR6EhOF4aOhZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4242be-cb71-4c33-8a74-08dc017db98a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:04:27.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Orh+CmHsSz8IBe13AhLWXSJ0lZAukeaRRKvdXCDGF8E03lLIop0XAzxkZvWuuTlcp7MpSyn7zuK10SUMKCGCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

On 12/20/2023 1:23 AM, Larysa Zaremba wrote:
> 
> On Tue, Dec 19, 2023 at 04:09:09PM -0800, Nelson, Shannon wrote:
>> On 12/18/2023 11:27 AM, Tony Nguyen wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> From: Larysa Zaremba <larysa.zaremba@intel.com>
>>>
>>> Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
>>> functions") has refactored a bunch of code involved in PFR. In this
>>> process, TC queue number adjustment for XDP was lost. Bring it back.
>>>
>>> Lack of such adjustment causes interface to go into no-carrier after a
>>> reset, if XDP program is attached, with the following message:
>>>
>>> ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
>>> ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
>>> ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
>>> ice 0000:b1:00.0: PF VSI rebuild failed: -22
>>> ice 0000:b1:00.0: Rebuild failed, unload and reload driver
>>>
>>> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> index de7ba87af45d..1bad6e17f9be 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
>>>                   } else {
>>>                           max_txqs[i] = vsi->alloc_txq;
>>>                   }
>>> +
>>> +               if (vsi->type == ICE_VSI_PF)
>>> +                       max_txqs[i] += vsi->num_xdp_txq;
>>
>> Since this new code is coming right after an existing
>>                if (vsi->type == ICE_VSI_CHNL)
>> it looks like it would make sense to make it an 'else if' in that last
>> block, e.g.:
>>
>>                if (vsi->type == ICE_VSI_CHNL) {
>>                        if (!vsi->alloc_txq && vsi->num_txq)
>>                                max_txqs[i] = vsi->num_txq;
>>                        else
>>                                max_txqs[i] = pf->num_lan_tx;
>>                } else if (vsi->type == ICE_VSI_PF) {
>>                        max_txqs[i] += vsi->num_xdp_txq;
> 
> Would need to be
>          max_txqs[i] = vsi->alloc_txq + vsi->num_xdp_txq;
> 
>>                } else {
>>                        max_txqs[i] = vsi->alloc_txq;
>>                }
>>
>> Of course this begins to verge on the switch/case/default format.
>>
>> sln
>>
> 
> I was going for logic: assign default values first, adjust based on enabled
> features (well, a single feature) second. The thing that in my opinion would
> make it more clear would be replacing 'vsi->type == ICE_VSI_PF' with
> ice_is_xdp_ena_vsi(). Do you think this is worth doing?

Hmm... I made a dumb error in a quick read of the code.  This suggests 
that making the intent of the code more clear would be a good idea.  I 
think that the ice_is_xdp_ena_vsi() would definitely make it more clear 
as opposed to the bare ICE_VCSI_PF.

sln


> 
>>
>>>           }
>>>
>>>           dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
>>> --
>>> 2.41.0
>>>
>>>
>>

