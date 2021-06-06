Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D376239CC8A
	for <lists+bpf@lfdr.de>; Sun,  6 Jun 2021 05:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFFDin (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Jun 2021 23:38:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53478 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhFFDim (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Jun 2021 23:38:42 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1563XvNF008813;
        Sat, 5 Jun 2021 20:36:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NM1/6Y9lLRX897pptWYfxqzXMKWbAGyH9ATQOHz2PWE=;
 b=oTIP9uQ9VKDsLgkpZw8zsaSTCd2WwNfTvmgT8JGL4fP+DX0USvlXraqTeUdJ1y7xCIlP
 6t5iwqbS93t6opmBHdSCTBDvpLqErY11a1KAb7Tuni8MSmC0h8nc0Ftt7HeQMEQkpO9q
 PIeHv4fPslfNC+7DHZivM/B0kjrcg0VQM5A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3906cx33rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 05 Jun 2021 20:36:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 20:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQGQy97IxdYGyFhbq4bVJoZTDMLO5zsGPONU7Z7aqswAuZo0L7/YH5+pJt7fG2znKl4mGoM/OBweG5zicCRvIC/Xhszh0TMo9n1dwV130L+KnccqBAO6c3Ghy3pFN9RncvWjIXd6uKaeXc4xTVqdXPPpYgsmgVhiXq0XQbHjcg9gD22lTZ0fCrZCad61zJZX9iiD3ps+inlrecBUsEWft8eDVT8FQN08wxqK5GijQ3wSVMkU1UFTKbx9Ln7RhU1yqABTm8lRTYub43lMSylgxujggZCMN9ZdRHdqDMFXBGpydz/eLPUj26F+WKNHTYR3QSBdWWmNPZB1LVXXgs1Rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM1/6Y9lLRX897pptWYfxqzXMKWbAGyH9ATQOHz2PWE=;
 b=P0Ykc23Sfa4bE95N4dxdLqaso+qpgfUFiW3eeP/JwCXcATkt2V7SGDPVVxmeovlKSq1xJYo/LXaMqjpEcz9S3qHxXA+yxcyqHWLRh3m6imvz7ZpUo104sdAAjr+AzA8QqRu0bi1s6avmWPPx5VgEepiqre3UzhAy/+VkWGiYDgHp0/UKBRoKnZ3yJW1UGNBBqgDA/Bsl1gFu6/iKf5JXCoPcvcMCuZ/7XLqEUT4OSfIpaY3weECjR1UtSRElTZfbap6P5RiEhmPLVwqXI8Sbqe3VsdswwAZpfxj5M6DJL841e7yAdQvDNE+opQUnTsBk3s4LFTLHQgg94JECFmDsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (52.132.118.155) by
 SN6PR15MB2416.namprd15.prod.outlook.com (52.135.64.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Sun, 6 Jun 2021 03:36:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.026; Sun, 6 Jun 2021
 03:36:34 +0000
Subject: Re: [PATCH bpf-next v4 2/3] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-3-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7f3a4c3d-83b7-22c0-c64b-918e2976ef57@fb.com>
Date:   Sat, 5 Jun 2021 20:36:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210604220235.6758-3-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f8c6]
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a79] (2620:10d:c090:400::5:f8c6) by MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Sun, 6 Jun 2021 03:36:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56db04bf-551e-4085-f87e-08d9289c4816
X-MS-TrafficTypeDiagnostic: SN6PR15MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2416DADC5BCAA37250C3617DD3399@SN6PR15MB2416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSJAgpWW6FY+MDSPsQzC/7Z48nns1ytIxp2wnWMJPV9UHWRs6Xq026LY9mgHn+siQw8h1iyehQgrFJjAZLPAyx1FJGMM7TsAc8JwxMr9PipcEwOzDqzC2RYGodI//2c8TK0Trry5aK8YufxprevMqlh1wbjmngrA56B/TDFWS+2EaXHJEk/Z75UlNbOi1QZ/DLguCX03mOJUtsZVTXJy5w19+v/q0W1qVK2KHluvNnaLE27iTY5lFI4P8b4WpZ6Mmgn7hZrTOq8P4EQO4a3pPsFVZHN+PqCh9X+49Iaz+dx32ZIZLY8cfJOkLC6aigwP+mo1HLSHPkbLhV0ijqGnFXGE7ti8RMJMyroypzA9VidJqHkqkJ5zU6HQ7Rr6VI9fC0DwRgyEbhCUd+HU92UNVyZ9RdeZLJ7vfWGZ6oThIBt+UcQT0om/ldi86QfKTa04XtXG7IjvEYzIjsDOpfVB0/TMgz6+wbhTo4XW/c5gg/vVZeYRa94MS6r+sm2M2fB6lYV6mIZoVp8oaCBqYSYBgSuZM8h7myblMz0O2d0de9bTaWM97G6sEYmCEovylHZU86oOvmZeHP0zbDXMp4KFK0yy3WwCXHoQNQXdTVoXcq/cp4aowtpV9mWhnbyrsVPZG/5Q55Yi5cLD5X+fTFO2J+5/tQa043FsLWbmildCdauGTvqliGvewLnEvlzEbknB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(186003)(16526019)(7416002)(31696002)(6486002)(316002)(2616005)(54906003)(36756003)(2906002)(4326008)(478600001)(53546011)(38100700002)(83380400001)(66556008)(66946007)(66476007)(8676002)(5660300002)(52116002)(86362001)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aitqa1JWL2FvL1R5SjNydlg1alAzZ2NGNXArSXVRelRYeURNeW9vZ0FDSXpr?=
 =?utf-8?B?K0pUVUc5dVhWbXFBRk5ITmJ3UUV1RDJFR0FUNzRHVXRWUEZqdHlSaGZLVTRi?=
 =?utf-8?B?TDFBWTlLQktYZVB4T3BBdWcxQ0M2ZEdBOTFYZDVJYTgzZS9ZMXo4dnpHQTd5?=
 =?utf-8?B?QmFMaWwxTWZscjRWMHd4OCtRRFlqTEJNN2V3bE4xUEt5QW5sL0ltNUxtb2R4?=
 =?utf-8?B?MDF3UG14YzdmZkxxQTJldEpoQVZrQ2hTUHhYd0I3RmhhelVBUFkxNUtSQ3hS?=
 =?utf-8?B?NVVmeWJtUVlMSC9DOGRaQlQyWGY4ckhhZGRZQU01SzRReTFmNHV2Y3l4NjBw?=
 =?utf-8?B?NERsajF4ZVpCS09FTjJ3c1k3WnBHUWE5YWo0RHhDLzlyN3JGbDRSOWlvcU0v?=
 =?utf-8?B?TitqZEYzN1NaMnJscnJwWkp3aDBMT05MSjYyaHp2b0NOcTRZeFNRdmM2MXhq?=
 =?utf-8?B?QXRLaURYd25UTUR0bEJmT3YxbnJkTGlsOUZjcmErbXZEREgyeWQ4T3M0ZFFO?=
 =?utf-8?B?MjBxTm1lVkFhRUFkUzNTclpjSFN0Z1dJRHhCTUEybGdBbHdXWGl2TEkrdHor?=
 =?utf-8?B?RUJ5SE9KaDNKYXMyZ21xak8yWEZRVFhTb0JDUExIRzZ1N01Hd2NLTmFoTGV0?=
 =?utf-8?B?RkZqaTVDUkpTdkY0WDk3Y1dLWFN0UU9pN1BlRWVObk9EeXh0NDQ1cnlZcith?=
 =?utf-8?B?eG1nbWcxK3pUc1lpTTlDNGtMc3VhSUEvWS84SHNFWU93VVpJNTlGRWhra1lu?=
 =?utf-8?B?OTNDcU5wdkk5MW1uV0U3SmlIbm5OSWRsUjEyWkF2R2VYS0V4ME1FTUhSN2lJ?=
 =?utf-8?B?MjVZRTBYbmkrYkxzZWQyZjYxbzdjUDhESTMvU0hVSWhMMWpEdUwzNUtMaGNZ?=
 =?utf-8?B?NUhrbG9YMHFheW96WGVsMlRQeFFBSmR4WnZEVnVhQkg1cGxOaHFxalAveU54?=
 =?utf-8?B?azRNdXU1QUpnOTFJWW9RLzEwano2N3RiMlplMEhPc2hhRUR2eDFLOEV6cmRt?=
 =?utf-8?B?dS9McEM0eXJLMDB5V0FpQ0F5dEhMK1NScjJzM1RtR3FzK0ppVWRNam4rcTFY?=
 =?utf-8?B?cGxHY2dXN0g0aGlHUUI2UkVleGQzOXVrWjJDcUgzZklML3FUTEpNU09pUDgw?=
 =?utf-8?B?TnBVcmp4bGZWaEZFU25QbitmUm5aOUl3UkFibXhRTFlRZElYNTQxcEk0UUVL?=
 =?utf-8?B?c3E4cWRNY2hYc0wrb1o5R1l0ZlAzbnh4Z0k4dlhxVjdtQ2xXMFNTL1VPaWdv?=
 =?utf-8?B?bzJpM0pqY0QwSUhZNkV2WnJyK2xSYk5JOTRpWE1yZU9rbzd5OGF2V2xaUVJO?=
 =?utf-8?B?NER4Mmt4YTFya0ZIcmxKck8yWU5PQXpyNzdnMVUxRlYzVXUreXpuZlNhSVJa?=
 =?utf-8?B?aFZBN1hKUjRjSVExZ1pXNkU1REJYOFlScm85NkdVdWV5U3dKK2U4NVFYU1pm?=
 =?utf-8?B?WG9FMis4RE0wSm5RbUtxVGxUTVFIMDJwdGh1d0dZUHZmS2tHbnRSS09TSEU2?=
 =?utf-8?B?cUZwNEFFRS90YWlCOTdOVFBJTERzSUNyQUpoWTA5Z3RyblhscjRUSGlWUWhx?=
 =?utf-8?B?S3RlazlsajJLSlhRMFlRRlcyditXb21uYW53RXg5VEpVWGY3Z281Wkt2U1Rx?=
 =?utf-8?B?Z1YwVWhtK2lRSXpxRGNmcWEwSFNGekkwYm0yRkpMV3RkUVVMNm01d01FMUcy?=
 =?utf-8?B?RlgwdDQ1M09xYnUxallvUUUwL1F4WGtBWVhNdUtxNjBTeHpsYnVjejdYL3Y0?=
 =?utf-8?B?WEF4MGNuRy9OMnBTQUpVODgydERqRFh6S0hFUk5UYjQzK3hJTVVBalNOVnFF?=
 =?utf-8?Q?ODeCcT/GUOslLM9x6x402ZDFXgtSSzd+RG2VA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56db04bf-551e-4085-f87e-08d9289c4816
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 03:36:34.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuUQNu5UdgSuI0ctAp+QgyuokaTvxe+zo2u/fX60sF0q8n08uzMOLXXD1R+5FAEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2416
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2GchTDR0CbpcJWs2bYP15h9IbL1S7fuO
X-Proofpoint-ORIG-GUID: 2GchTDR0CbpcJWs2bYP15h9IbL1S7fuO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_01:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106060027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/4/21 3:02 PM, Zvi Effron wrote:
> Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> contexts for BPF_PROG_TEST_RUN.
> 
> The intended use case is to allow testing XDP programs that make decisions
> based on the ingress interface or RX queue.
> 
> If ingress_ifindex is specified, look up the device by the provided index
> in the current namespace and use its xdp_rxq for the xdp_buff. If the
> rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> 0, return EINVAL.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   net/bpf/test_run.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 698618f2b27e..3916205fc3d4 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -690,6 +690,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
>   {
>   	void *data;
> +	struct net_device *device;
> +	struct netdev_rx_queue *rxqueue;

reverse christmas tree?

>   
>   	if (!xdp_md)
>   		return 0;
> @@ -702,9 +704,21 @@ static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
>   
>   	xdp->data = xdp->data_meta + xdp_md->data;
>   
> -	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +	if (!xdp_md->ingress_ifindex && xdp_md->rx_queue_index)
>   		return -EINVAL;

xdp_md->ingress_ifindex and xdp_md->rx_queue_index are used three times 
each in this function here. Maybe worthwhile to assign them to
temporary variables?

>   
> +	if (xdp_md->ingress_ifindex) {
> +		device = dev_get_by_index(current->nsproxy->net_ns, xdp_md->ingress_ifindex);
> +		if (!device)
> +			return -EINVAL;
> +
> +		if (xdp_md->rx_queue_index >= device->real_num_rx_queues)
> +			return -EINVAL;
> +
> +		rxqueue = __netif_get_rx_queue(device, xdp_md->rx_queue_index);
> +		xdp->rxq = &rxqueue->xdp_rxq;
> +	}
> +
>   	return 0;
>   }
>   
> 
