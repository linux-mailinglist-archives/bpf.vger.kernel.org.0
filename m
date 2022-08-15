Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D15593899
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiHOSmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbiHOSlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 14:41:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5AC16;
        Mon, 15 Aug 2022 11:24:59 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FHbHHN018418;
        Mon, 15 Aug 2022 11:24:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=u7vEfa7sHs3W2Lrdh/UjRe1ngpMmCy2jq2Hl+0vx3FA=;
 b=KKVIXfFT+QRPiA1+rzhrNZA3ojOf752raUbqRZnhZYAclLF8zDKTlROlnLKN0/3AkhyA
 fX4MJ1IjMVPctv/5ORBTD43zrMFTlqpEcjWxUJG/VZ0suuQ/SH9kRQ15h+K8uhKWKz6E
 agrBED2NoJtZ0qyurGE4HB9uJxJCuEuDcGE= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9fymd7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 11:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSvA0RSL7xaD+okOyNzpsx5vrromJUxa8Qaosqva6VmGSimbqM26MXcHxDL5T1axKUjXWnGyg9TSYIe8Tf3k8LuPie6p/SE57blqxI8NYsHDKmNQInP4cnun5UOz1tX32CWyjZX6+0ulABpzIy4FZwehFTUJuY+DVpqTLde+PJN8MGW1V2s9JqQuqBFs5wBakT70XfYU5cYgcy96dWSJUC6RFb25jDku4xocjSDFKFzO2DKBH6PIzZJRHdvnv9sPIk5Sf4yHgVs1gVuCi96qEiGM89vxY/H+kmZgZW+pgJGr2Z3HoHX42iA9ip3mKRWlg3enSNG/QbF++RCIhWedhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7vEfa7sHs3W2Lrdh/UjRe1ngpMmCy2jq2Hl+0vx3FA=;
 b=WfoY1HSjmJcAdlzwk3ESjalkbrck/gelhRcJ2GEMHGJP23OL7hfJBSUWNLSDzW7ylhUH1x4V+5kBXbQ/s5e4pwOiGNx0RC9fD+RHRZhvBjdIMBzgQvOXTfOkFSdbjkBNa3Q7kWac0fgYP9ZkTmLstHqD8U9rBetSlxNH6Ok5XIXlNpwjNccwhNquFvFZFsH00yJSj48nkMItg7N+PAHfyndK3WDS+aERyMnt/UaeOOCJG5xmWUhXiLKGcEcI5YS8b2X14I05MQiUD/s8E+3GFolWIA8sYuLLVdS0ryda0iaqrGPhKrplLIJCC59kGQgCTKhNZHEHIhms34VDfKaiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB2764.namprd15.prod.outlook.com (2603:10b6:5:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 18:24:30 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 18:24:30 +0000
Date:   Mon, 15 Aug 2022 11:24:27 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        paskripkin@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        18801353760@163.com, Jakub Kicinski <kuba@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] net: refactor bpf_sk_reuseport_detach()
Message-ID: <20220815182427.afep7xxchgdbyhd2@kafai-mbp>
References: <cover.1659676823.git.yin31149@gmail.com>
 <68ea55d47f10ac8faa0d44e184a5ec00a9dd0409.1659676823.git.yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ea55d47f10ac8faa0d44e184a5ec00a9dd0409.1659676823.git.yin31149@gmail.com>
X-ClientProxiedBy: BYAPR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:a03:40::45) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b4506c-6e73-4207-f094-08da7eeb650d
X-MS-TrafficTypeDiagnostic: DM6PR15MB2764:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWO88g+DlYjbFFU4naNJrsk3ymhcBvj9w8KSIf/0EBYiYR7x9QkXWUqiAEFTGvmK93sZLJJLAMRE1n7cD4kTxvkG+KUef0a9Cu4OC+QY8DWOVq0Z8j7nednUwwsyVfHmLnL6LJduQtshbim7Zm605pzIVC3cg697mQOtBfEeXJuvZISsRgVhaZ370M/ZeIS4EfHtf9+4zahcfFK5I5cEdXhx7NYuBM2KCGewiO8sbqUiHQFMxEHGOUcjMzKpiHhCcJZRvu53MZj1zCBAO0fn5OfzHmhv4tGcJIMlu2lMgScXprciH/gkxFBROQhw71lC+GqnucDuhWEPBvci4zEcYNgByI08CW05HScKgmC56uyQforlXR7Go/RfJTBKLq12hBWL0iMPRfRYMCwjdiwenVbWixKSTHCwHCjrkQRWZgPb9cUM/xH1VD/nJK11qzs9vNoAf0KTXBCJ+cGyo0kuQE51s3xtNzTnuYaECxB5nsBJyXCYAIESMY5rcqEi1UgxWgTaDz/yoztCBzcFvDWxMuUhgGAwJ7Ax9Tc1o9Yq3itUrAG9bzoYMyxLZHwNobI7IblcwTB11x3CGNb5IxTuvm0/TDUzpXpRT/dTplEkLInOXMtT0NGL6F50Jj3WAahEY+75LeMl6I0GMLe74/oxepZBxzvfZFeRIwMeo5u68ayqGjHWL16WDvIl/ITUUsAix6m1fOVGUetLlpxv2q7qzbqxVNSwxxubFviiL+bDNMxlHKk53qepn8PTPgMpunF7ySSsEPeDZ5Ao9dSgPQyjzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(7416002)(2906002)(33716001)(86362001)(966005)(38100700002)(6666004)(41300700001)(6506007)(52116002)(478600001)(186003)(1076003)(6486002)(9686003)(83380400001)(8676002)(66946007)(66556008)(66476007)(8936002)(4326008)(6916009)(54906003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpGF4G44zQWrFobsr5Cw5sy/7Zw+xlbpWmisiX2DUMmg9Ncy5r0SsVc0PzI2?=
 =?us-ascii?Q?ME8jP9zocVszjNWeJDZ2T7IcgY1ZDAp+J5gX4uWmjLh5EXibv7OE59OYrdEK?=
 =?us-ascii?Q?ZdX9vDtjFS9BI13bmcRd41tZvYR5iW8veKXb3gMhvq3JuE4+9X3gK3s9EaiC?=
 =?us-ascii?Q?B1nlySdYVkRoj1SvBJPWvLIGWC+a7cU24qSplgwt0BEf4SHGQyH54MnGM8R9?=
 =?us-ascii?Q?C2nvkKdG8L6dNpaPVa7EltSTl/wCyDSh0UDaIKbxixTzl4+HZympz+ikMaDr?=
 =?us-ascii?Q?uf9tlaCheESdlSaExTWo9QPzLuYaKeYIbcK6hYjX8ljjyu/yuymVhOL+bTJZ?=
 =?us-ascii?Q?rJ+6c/5gdgQqwuwkImk+I8zwEFwtDnY7cDMK5h8MaRUs+wcFIgAY8DC56Fu7?=
 =?us-ascii?Q?/Zg+B+2BYO5hc/XNf2psZJo1oLOIIUtlS4qZ3pGNKEqqnu9JQ1HWsyD8BHew?=
 =?us-ascii?Q?vqT6nD/F5bchKxRyl9Rvlev6HTM6tBls9uyVklYzZm+CiDHeHoe7XS1OBFPU?=
 =?us-ascii?Q?JH9hwebvFgaPKJobJxMOSbwL+XUVJU73Xnp7HurmGm/zqQTjnyvWLRNn2d0e?=
 =?us-ascii?Q?fYCT0XtsDbM/1v1J1cV1+roRvsEGo/a/mKAJ8zD4UkD41lyzrHvf2+a97YXq?=
 =?us-ascii?Q?f01u8fG9qqqZ0BjFGvN/5NMOffpV6+lFxZP4H5RRYvwGOE0yG7M2WEfxIQVQ?=
 =?us-ascii?Q?x8FPEz9ZHXPpWiBdvjUBC6IpMgUUc4RYeyViYeqXQHjkIAMX7XBQB9DfVpU+?=
 =?us-ascii?Q?I/nAVUFh1NP+Aen6NFpxlgjK+GjV043GXV9ZzLXXsxGQQsDgSkBPoAN7Ty2C?=
 =?us-ascii?Q?UdyyV+8jFfAuFziGQMBSpEERNsFAX3ntWn17kh4LOxLL7vkLeGQZg2ynt9ag?=
 =?us-ascii?Q?GykoWKfVvdlPXpQkD4BJPAec8rDzOXpL9O9QXxAa6FKiq5tD/VYcKa2orytQ?=
 =?us-ascii?Q?BcvqkpJdvgAurKpSc+4d6hc9LTYGcbhXc1hcM6P16klfAP+ng7gkT4GIe+Ja?=
 =?us-ascii?Q?rMeVSm6LsHxm5XRPZvwDKqu+KHzo24YlXQczO928DOY9Iemj5QpZM4WOJsP2?=
 =?us-ascii?Q?GrH/o+ZFtSecAfjRXHl4nEEqjh1y7Eh4vkDTyoiOkUEUzZ6xbekdSVGwseJI?=
 =?us-ascii?Q?8m0nm7d+As5QgiiFXT8nVBHldpisg+VeOYOuBybnNjMDBZ3dT4uEMckI/elJ?=
 =?us-ascii?Q?rhD4Dk4IyoPmq22id7IbU7N84XztqPHyKC2u3khSidErolkml9VPHc18OqhD?=
 =?us-ascii?Q?oQM9MKoN8Ox70G/iYuFoEbC3J6gCreij20+AUH45Lv0r/ltTZuv+p5rjJnlo?=
 =?us-ascii?Q?lLjHeKsm/rg9oix8EQRS22bH4ecrHhN/z9OUcxqjOBHvL+BYneP+4FNvLPB+?=
 =?us-ascii?Q?e5OEgWCZZdJnG74BRmFoVscsMcUujxe7UJSnLqrnOQyqh7Vvw5coZZ315y5n?=
 =?us-ascii?Q?QbHzpr6Mu8JQUV4LqXmpOpGDpw5mCqUhAUt62220pyPwZDjMtfw9/gctC2r+?=
 =?us-ascii?Q?IQ4MTuJ+gPitdqKozmWqn3addVRrlvK17r2U0QgnJAtr8cwPOnBmxaqbjSGo?=
 =?us-ascii?Q?LORFFmiyWr9gTxbmSd9jbPC5yFmfrQ0r7NqoATxD3/rKj/BrSjypOrEsYqS/?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b4506c-6e73-4207-f094-08da7eeb650d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 18:24:30.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rglmB6xYqxYz/2BQxBRvmac+Y1OSOf7FzUR9cI+INOfQmmIBz5huUsifbM+IwRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2764
X-Proofpoint-ORIG-GUID: CRRzaTyihQ2gw5dnsTafY467P3ycaPN_
X-Proofpoint-GUID: CRRzaTyihQ2gw5dnsTafY467P3ycaPN_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 05, 2022 at 03:48:36PM +0800, Hawkins Jiawei wrote:
> Refactor sk_user_data dereference using more generic function
> __rcu_dereference_sk_user_data_with_flags(), which improve its
> maintainability
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  kernel/bpf/reuseport_array.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
> index e2618fb5870e..85fa9dbfa8bf 100644
> --- a/kernel/bpf/reuseport_array.c
> +++ b/kernel/bpf/reuseport_array.c
> @@ -21,14 +21,11 @@ static struct reuseport_array *reuseport_array(struct bpf_map *map)
>  /* The caller must hold the reuseport_lock */
>  void bpf_sk_reuseport_detach(struct sock *sk)
>  {
> -	uintptr_t sk_user_data;
> +	struct sock __rcu **socks;
>  
>  	write_lock_bh(&sk->sk_callback_lock);
> -	sk_user_data = (uintptr_t)sk->sk_user_data;
> -	if (sk_user_data & SK_USER_DATA_BPF) {
> -		struct sock __rcu **socks;
> -
> -		socks = (void *)(sk_user_data & SK_USER_DATA_PTRMASK);
> +	socks = __rcu_dereference_sk_user_data_with_flags(sk, SK_USER_DATA_BPF);
syzbot reports 'suspicious rcu_dereference_check() usage':
https://lore.kernel.org/netdev/0000000000007902fc05e6458697@google.com/

rcu_read_lock() does not need to be held here.
One option is to use rcu_access_pointer.
Another option is to use rcu_dereference_check() and pass the
lockdep_is_held(&sk->sk_callback_lock) from here.


> +	if (socks) {
>  		WRITE_ONCE(sk->sk_user_data, NULL);
>  		/*
>  		 * Do not move this NULL assignment outside of
> -- 
> 2.25.1
> 
