Return-Path: <bpf+bounces-18349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB71D8194F3
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB481C23B8A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738F1FA8;
	Wed, 20 Dec 2023 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t/QlxG6R"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7E184C;
	Wed, 20 Dec 2023 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8LNj3p9II288WOOskYnExysblvBGYGwXNukfwuw3YbJLpXiw1bNk19HSJrHZ0zW0CA/eRWwoQ6KoXrcPYxNMMVJl9kgf7inUq2aVGrrN21ee02gxnPAFzkx0M3h2oIDQepxU+fcCgl62/JOWOcUqQhRXh6lGiohW+BDE5XlvzQ6ysDvOCwBwwa+S92UBfqzwPhy+VSkGimDBPFXovuU6jzixgFHMG/KnFSfYCFjSunuW/E/M6LYtjVO0R0isILIbCyoxMOirZDcDTlQa2pcBUfNING74eh20tgLoXm+YAAIsoUojvryo8UYGiksBtU36DdZs/UVu2IM9UV+CHZFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRo62tfYbuaX/lnDoB4t44crQOE61g3ANhWS/TSWw4w=;
 b=fzOBD3vGKITSToV8u9dSPIz+5YUrMEyia9J0NzlDRrgDVcYZvCQUy54/xCZjaPzmk2Ss/vxA/deN9tLpPwATShQcSQbKtRQ58hX5T9ztfENfY4OSNBwI0DZoG5ZcT0T5TMhoC9nap8cqoBL687pKav6zIEJBJ1NWImgyimVsLqsRleEzPWzlBEG6yq6eLLLZIwhuP7EOisioa4M7oBaC4qvliXdWxUsGY3OLc5na+MJQz0QmhIQjd5t1FZdPnFUSi3h1OWSQgfvc0BbSh8axtpHtDEJaQLlMOcNyixgcqKisMppjfW96gQlApvvo6YGxpUo0tna+EY+ybIYpCWKRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRo62tfYbuaX/lnDoB4t44crQOE61g3ANhWS/TSWw4w=;
 b=t/QlxG6RJ/paJxuYhbYKo60lJUkoGBtdnv0+7B44Dhp1mS2GTfzrkBqapzoQCDBw5n3Mgav//bGwTOGVvUt3/rjcC2k0r/bh4PqbKazPaHDLCqzcfiUJe0Bue0SoyerE+4mHNaMmWewn9VkkZ41tGGBGJq2IhFr71oBPygDCFMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 00:09:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Wed, 20 Dec 2023
 00:09:12 +0000
Message-ID: <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
Date: Tue, 19 Dec 2023 16:09:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>, Chandan Kumar Rout <chandanx.rout@intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d9b0ef-06e2-4811-47a7-08dc00efe4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUF6TACtUVFj8SA4+hi3TiGQAkVR9j8F791x/vf0oXnAK25UN1OjwdKbhO1GQXU5jGG/GTPWivYpcKqoRMGn0X4lCNJL2V9CqLFT29gYGp+z2IQQrJJX4mqIjTCOxwX/bT1ynozZSLVxRPGyHkvtxtOd6pR03Ixe9Ru5/W/bHtuLocAu9D9vcBYHgzBkV6PQfkquO0VwxCrid3vlXq2+EfE//hihQxqiFk+9+X9mWmgo7Xg7b2YdyEWLFdB3ICCK49Ym7uowVTkUa1TBsZoPaBiySyKbDAqOp8g6XcSdYifyStSeu9cHd4A6F1Cy7/PG3CHl0Ye9HXP9hkwAsCialIGz5N3SvpPUMKgweFut7bxhS+ftIdp1DL/LHjAJHJFOzK+oP2nJMj+vfVt6VdR4mpKqn6W33KjfqhPMS5uDNxi5g89CwkBNmtYrD2934LAGbWavGomTUCncev5JQ1yu/O6WmSo/VoMlBSJcTuT7lEZ0akl/5vEuHWEWX7HZSgZZuDRDG3zVfRtrjsi/JK4WrLzE6tu1jETM5waiaeZj2b3lv9zM6evsYl532zBgfCsn1eWBn7IBWNpSQAvYUO0QDm60W6l+6WSpdlIvFVE/6uMqFJXlcNOeJkCIUpM9iv+PPS4ER1+YluB6RV8XKBvTxhmIAkHbsHk2tb8VSA2lK53KK6I3cuk9Xh/6vx6zKCFV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(316002)(8936002)(8676002)(4326008)(54906003)(2906002)(6486002)(478600001)(6666004)(66946007)(66476007)(66556008)(31686004)(6506007)(31696002)(6512007)(5660300002)(83380400001)(38100700002)(36756003)(86362001)(7416002)(2616005)(53546011)(26005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVJSTEZSS1VUNVJFWkQ0QjBNSGJUTlhxaTFzYlArWVdyOUVNWGZ5ODkzTTk5?=
 =?utf-8?B?TmtnSkE3VVBTMjlWVTJxTnhKb2N6MzZxZ1JsYjRmNnQ3cUdUODlYSkhHWWV4?=
 =?utf-8?B?K0l3dVRtSnFHcXg3Uit0NG1lZnEwTE05UWltTWZOYXMyMlZOZUVORzJUcnp0?=
 =?utf-8?B?aFJyZWp0TnY3bXVlVDRuM3lHRHB1a3A0RzdkZmZCWUxVVnh5RFBLMVdzMytv?=
 =?utf-8?B?QnFhVmpoakc0dlUxSFVsTXE3UkV3dmhaRSs2UVdhYU8wRHdlcFo1VVRwM1Iw?=
 =?utf-8?B?dWdCNW1CWUI5ZC9BTGhDYzhhNDFKbWdBcTZ6OThKNnpISFRXQlBsSDUyMFdM?=
 =?utf-8?B?bGxsQkt6eTAwU04vRVFwSER3UEN5WXBjeXpKZDV6RVBlaHRja0VlR2RxL01l?=
 =?utf-8?B?L3BCak1XaXlHV3QvN0xvL2Y1TGZaZkJhRTBEOW1YTzNaM1NGOUVkSkNNTEdS?=
 =?utf-8?B?UlFHVUI5Q1FJditvUzhmRDVUNjdKRHJVQksraUFKQXFpNFFqdkd4WWw4UU9a?=
 =?utf-8?B?YXk2UUxzT2R1M2ZCZlhmQmE0OWR3RGVUM3lTL0R4V0p5MUprdzVnY3A1Zkdk?=
 =?utf-8?B?VHRIKzU5eHl4OWdIb3dINjRZL1NZd08vNjhRa3VQUDFKc0JVeFU2ZFluVGgx?=
 =?utf-8?B?QlV1dldHYU5MUUJyUE93LzJHbmQyN0Q4MFplTlUyK0pRYVhyOVkrRHVsZUs4?=
 =?utf-8?B?N3dZd0h0QlRoazhEcTJNRThNMG5XeDB2ZUJ1UDJweDVnbHg2U04zWGdOS3N5?=
 =?utf-8?B?OVRYVDEyMGc3MEZ0MTFNMEl5eURsM3hUUGFuVnFuc0JrUXN4U2ZrSURNRDVv?=
 =?utf-8?B?RzYrdWRYY0RxTmIzS1RrVUtlWWZFc3RqVE56aEpVanNqdWhkc09zK0g0RXlR?=
 =?utf-8?B?Kzd5V0FDb3g3dFFGcTdkR0xubkVvRVR1RHUxV1o3TzVWeGI5WDFpckZTTkMv?=
 =?utf-8?B?V0gxV2FjZVRneWE3V1l1RGQ2czdpTVpYZit4VnM3ZFFjbzN4UmMzblFGSGlV?=
 =?utf-8?B?QWxGZmFnelNQR3M0dTZERlgwRExCMVJJNTRJcHg1eDYrMFh0ck1EUmd3eEta?=
 =?utf-8?B?aks3VDcvZ2lCRkd0MkZ4WU15YWtKZ3g4MW13cDJkdVQ3YWhnSCtsb2pvVEIw?=
 =?utf-8?B?YmVHUUZxVk15a1dlSnZDTmJMc3h1L3dZTEZjd3F4VGlqbXg4azZ5RG9ZS3R4?=
 =?utf-8?B?bmc3TVRyeTdERFd5a0VWR084TXdyMjFMWjBuZkNERmcrTjFiUUY4QU9LWXdI?=
 =?utf-8?B?b3hWV2tiNTBJUG4zNzV0NVJzRkg1QW5hSDQyeWN2NjlvU01HQUtuLzZBQTVW?=
 =?utf-8?B?ZjA2QmFTLzhqWWR1ZG13ZGJHdDZSdVY3c256dm51VG9xWllFOSs5a284amxB?=
 =?utf-8?B?NUNzaDZUeUY4MlNJVkNEbFkrWmYrQXBsZk05aXNMZkdiUk85SzFqV1lIY1Iy?=
 =?utf-8?B?OFlRbnY5MTFTblk4UTJ6eGgrZUpqSjM0NmVzTHdqMzVyemZ5MURYa3J0MTVp?=
 =?utf-8?B?MXV4L1ZZNCtVOTMrbGpCTVVaODNCQzJJYUhDc0xlRkZIbS9TK2N2aWNPQW9k?=
 =?utf-8?B?V29Vd2RjWGJOZENHOThuSXRVWndmRllWM3lpYzRxTk9wRmZZcmpCYWQ2VTRV?=
 =?utf-8?B?aVRpNnE3dDIzVUtkVHcvYkRwRFBNeWFtakNoSVlqeFI5UExOSmN1c29nUnI3?=
 =?utf-8?B?NlJ4WE5FTklRZEJ3NmxTVUl0R3l1MmpiNXByOGdEVGZLdk1VSzFyVWNDdGJ3?=
 =?utf-8?B?S3l0R29hUDliWm1zSGhma045RmF5eVJXa3JhbWNTRS85TzRrWjJ4UnRpS285?=
 =?utf-8?B?eE1TUURmT3c4MGFVRTYvQ3JxeHk4QzhieW12TFlGUHJqZnEvcU9mNThzQnRa?=
 =?utf-8?B?Z3Q2Rms4U0QwRGtPaEUwckRZVDRuNUIrYUVvV3laUGE3YjZQUWVCbjZzWDlk?=
 =?utf-8?B?SlNLN25VRlZ5OGZORDlBZ1pHOVhkVDh2am90NjZrc2tVNEVQemdOYkF1QUcr?=
 =?utf-8?B?aEJTY2VjeDlNYnY0NHl4KzZNUGw1Yml1ZFZ3SkJPNXNrUXJqSjBDUXhxR1BJ?=
 =?utf-8?B?akhhT1FTNFJNb2hqeG4wdGoybEFHRnk4djdjQWcyTWtiWEE3L3ZDV2lFdm8v?=
 =?utf-8?Q?isw5NH9OzND7e88hO1z81NvQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d9b0ef-06e2-4811-47a7-08dc00efe4fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 00:09:12.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZb+Ji6kLFqP4dCU/92njz4VaASWRDq2jvacq6/WW2Jdd/ZEJV2HWw6RbHbKzAf45cF97jwa0pf4zNzjURFhmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482

On 12/18/2023 11:27 AM, Tony Nguyen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> functions") has refactored a bunch of code involved in PFR. In this
> process, TC queue number adjustment for XDP was lost. Bring it back.
> 
> Lack of such adjustment causes interface to go into no-carrier after a
> reset, if XDP program is attached, with the following message:
> 
> ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> ice 0000:b1:00.0: PF VSI rebuild failed: -22
> ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index de7ba87af45d..1bad6e17f9be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
>                  } else {
>                          max_txqs[i] = vsi->alloc_txq;
>                  }
> +
> +               if (vsi->type == ICE_VSI_PF)
> +                       max_txqs[i] += vsi->num_xdp_txq;

Since this new code is coming right after an existing
		if (vsi->type == ICE_VSI_CHNL)
it looks like it would make sense to make it an 'else if' in that last 
block, e.g.:

		if (vsi->type == ICE_VSI_CHNL) {
			if (!vsi->alloc_txq && vsi->num_txq)
				max_txqs[i] = vsi->num_txq;
			else
				max_txqs[i] = pf->num_lan_tx;
		} else if (vsi->type == ICE_VSI_PF) {
			max_txqs[i] += vsi->num_xdp_txq;
		} else {
			max_txqs[i] = vsi->alloc_txq;
		}

Of course this begins to verge on the switch/case/default format.

sln


>          }
> 
>          dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
> --
> 2.41.0
> 
> 

