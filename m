Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCAB4E6965
	for <lists+bpf@lfdr.de>; Thu, 24 Mar 2022 20:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiCXTjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiCXTji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 15:39:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9C2739
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 12:38:05 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22OIwXmr004913;
        Thu, 24 Mar 2022 12:38:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aMSGnpis0gBl/pzJP+0D6OoaNQuKFNDLj2wp6p2gFzE=;
 b=UyMrwxIiy5jUU3nia8qY6RVdBQR7NqpfBhggDPp3AJeP4T6WKxIdENvjirPCtweo4hSm
 +Gi4ryGe5pzKOvAmgp6bNdOv8NW/+UyT4Vg50ZGEM0LZxXBtfu2nY7yafpluQF2o3oET
 35ASfIWvuYP9CRZgfVf1T/nQSPRLz2kDBzU= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f0n6vm51r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 12:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Fl2BkkDIhLcATyOVqGCIM1pf+s1v7fhybPfqgVYBXZj1YYeJRkowvpPKv5H8WJApAtSe6QcMr5cjq1hiTFaB2Mo5oo8U71x3PVRwua3f4h63SjxuWr4gZjraVo/Sj3anFLA07TuKEJbBntURKzec1einPzsgj9guAQOP+4Xw4qqFx9NnA+qOQEXg/6GcmeMarVHHK74FHy4F3z1ie3lkqasPxPb5r+Hjdggj97SRzNk4nneBS8OY3tJVYqQi2oPnRRcONvrPpz+EWu6WfbjUpP1FlTwXnh8Dvrhs6QpCmtcUcUwRW81i1RYAJ4LTjephtwL3JKIMLmc8qacB5WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMSGnpis0gBl/pzJP+0D6OoaNQuKFNDLj2wp6p2gFzE=;
 b=Fuirh84LeirtFN3u71GRQgx7RqGPHlqGxzjnYjwdqAKcrhCT/Op26un5i+t4XGmAWrK4aVynR8SUu52cYDEAaSz6eQymf7DsVdY7V4n1Qi2d/On8f9Lctt45FQTb6TGVcyFifO5h0/3klF/AQglvkpp0o6GF7DAQmFATWFzIDbslqF4DbaWG+ubKDFzrw0PrR2gcRlt9yfKx4oM2aacda3aDOguzXdkJjEVRRvXDrlDm6DDFgDISG4ZcuBWN8iCqxVAlr18w6Xa9HHlgKl+ReQzknL6DNrwPgfYbu4MCOmuOSt/pb/heEul8BKTmi2WbKlS0k0xVSEy95MeM//DDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB4000.namprd15.prod.outlook.com (2603:10b6:806:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 24 Mar
 2022 19:37:59 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 19:37:59 +0000
Date:   Thu, 24 Mar 2022 12:37:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     fankaixi.li@bytedance.com
Cc:     songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
Message-ID: <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322154231.55044-4-fankaixi.li@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fb40ae-b78d-4ec9-a3a2-08da0dcdcd65
X-MS-TrafficTypeDiagnostic: SA0PR15MB4000:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB4000608D81D0B6594DF6D086D5199@SA0PR15MB4000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2Kbqgl+MHAhcnzs4nQsiqQc470l+BHBeV3oWvXSkDZr2I7FUe/gOUDXh0tcmuK+WRBHoSIGoYjHAoAFt+kvYStWmLnMRsz2JSbqlNDcVJEx9tZAWmJnFIkNbMOc3yt8nUq4Pu/dIzoTSBIa5X4MgnP9kNtMrBkfElAQq3WopXZg4AjIjRDLD41MJZvinrxOV+xvn0zw2ew4bqagzPDbtYfpz/01XO/NyIurz2EJD/ds9rKRVKDlFY3LdKMSUn5IqG/eq+RRRfZv+G2IXYMNAaWlfefM3oBTJazZNaJQk285LIma2wr1Yw1xKNSoGyjHr2WG8bpQmNrDwCZmob7zf+p1CiRCf/43/VO5eaD/XU1AQ6JQ+xKP4Q/M0orOBn8uqbAqva0VurkaZbSVvx/So8S+5S43w9ZOjnEpw5AH4X0Xu8YeayZowf5riOSmyQEdJn81RJkJt/KFZsoav8PS1H/53WHgVHGdXV6JCUz6Fd3VeqbRcfuALfLtVtbJsNCw+J+wFnIM3jRMBN7+LPBEIfZMRsLy4/OrB2FtFLf8EkT7Z5PWnuNBsIMFexySJJM9PKlV6WCYlug7g/l1J9fFQkAclqngvRvoKqoS7gPXKBqPtlMxAbwhOSi395/2Qdb8Yik27MS9xcpOVu/VjioxbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6506007)(6512007)(6666004)(9686003)(2906002)(52116002)(86362001)(83380400001)(33716001)(186003)(1076003)(8676002)(38100700002)(66476007)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7pBW9JUgUBB1+IK2HzHd7bHw0mXNQhopCNAdalbHAHnoJPa8ca3kJTufCOv?=
 =?us-ascii?Q?XLO2h3B4wwj7gcbA6BgeUrMW9TTRb7VXIeHn1e7XmRIpjLw4Nl8CLu+XZc4V?=
 =?us-ascii?Q?FpNxzHGCdcgz1ZtOn0TMmRjemtGUkYDywYdKsYefENbcSx4pTbEI1FgTh789?=
 =?us-ascii?Q?E+wDNHmgnw6ZrAhkk9GI8EzWmIqINMJvdVtuGugFC4Kq70mq/HYBX1sDxpyN?=
 =?us-ascii?Q?ZnYx1U2Sn7bTthwqck16SHJuERSiD035VNeraw5d2lqGnXn0b59pGTIs0pS9?=
 =?us-ascii?Q?204hJ86ZgRbmo+yDQjpW7NXjlxCTJ/5HTdgVViI73XXBh3lLuAqwUYs1kzmY?=
 =?us-ascii?Q?l2fEZ1CzQiCpVJmjiuetufZ4UC2q3PzhP/o8vGtCSgnsSJgqV9g9wEElwPPu?=
 =?us-ascii?Q?RhEKU0uKwhDJpTQFJVu7CHxvi6k51sdFzZbclno3iQy7MQ3A334OsGsCf1XS?=
 =?us-ascii?Q?696yP8VOhB4qiDMNS8zhfBIWcML1ecq2BOtDkRtqo5R3kgSVPXeTskj6zpFK?=
 =?us-ascii?Q?hllNPJRHuGCvLP4IABNLJTuiyR3lPmBu60wE/b6kSw7Zy57d68WWNF1TIoAm?=
 =?us-ascii?Q?V6SjyvK8iPYa0566KxVwkQVPySYdSiHM9ntQgE82ANo+nm8v9LdlVYg+qwtW?=
 =?us-ascii?Q?AsWt1OFm+07AlgBA9Zp3xvmJZMjBKWsdjT8va8TmPvfNydB2niPwfa4JkTD0?=
 =?us-ascii?Q?Z47SshB1KsbMSNneII3JOXSRiQzEPCdxB+yHzrBDXjP9/fjW/0Y+ohknWfdS?=
 =?us-ascii?Q?f/4KkxWGMf0FSEz5njt5u3u5Elt/CyjPBO8pEYbN2olTKK6BPip02CIIQpDb?=
 =?us-ascii?Q?nrtwcUQdT54wjhN7vNQ6ibCEPwGHQ3k90AxrSs9JXyWpOfFgKQuZlYVSGCI3?=
 =?us-ascii?Q?xqGerwRgNJAGloZ7mEVRPXLVC1YLGLju8juI8z6KnRcUACbB+nku1Z7lIdUc?=
 =?us-ascii?Q?pf3AdubFxUfWeIpdLg9EsFvbA+NMcemhI2BIzXKjoEoD9IFZlWmXT3Vjcy7Y?=
 =?us-ascii?Q?27TDCdAdYJGQ+7iPi4UGttbxEE9GwAnUelx1oEwpVd4g1zOVQ2GAXIUkCkua?=
 =?us-ascii?Q?JMJChKTv7/4vTt2iXYT00NmP51CI429YYYcP61ePiCSi3lFBNGJhFY/GnCcD?=
 =?us-ascii?Q?yUcW6bTlhV4BTLdeKUlKxDnUV9eHwKp+hy81dQctdrmxtACGiz6+73fKIsxR?=
 =?us-ascii?Q?6HgRAU1HYraTzYsVbwb289icwN4f78baCIV1RxI+j+xka5edAQHSJWkPHMWj?=
 =?us-ascii?Q?5D5BvGs4ta1/cEpXuQjsKa7IjCZjnE+2xJOaEikwVLO9cbfhy3wIqJ2fyVvY?=
 =?us-ascii?Q?Y4SG88TMIlHf+tdSNAyfbctXRlGGzrF6krbpFXV5IwMaQ4yjGeO8mYNz20oR?=
 =?us-ascii?Q?LU8yc2nntaByrZT1av7Fa9pEToTArBL+kRvAbg+77nctsxHypzQxP3wMb7qT?=
 =?us-ascii?Q?Y4x/PYTvFy1snC8IV+FBZURq9GTuBiIX6IsWS30fgd4DwFvCIMV9KCGlutJv?=
 =?us-ascii?Q?g9J1ahIyfirPXFiT/B4LEc6ewZjjo6wFtg9Ag9dPTUvMdP3/PNeBDqrv6pJb?=
 =?us-ascii?Q?B0/8Ww/AedEEgmxUwdA0hbCpjlxr5cf1MIqMwGNcN+z4NDK+RRIse03eV29t?=
 =?us-ascii?Q?z/HS9PIavTL2xTKjDQI/qdPB8GQ5Re4DNyOnww9y/jVHamAOvIxT+SqkRClH?=
 =?us-ascii?Q?Zz9MdetuFnshHqO/cTu4T0Dqmf8S8ONQ7QMWKYlTaA8aimG0Hg8Uw+YzW2HT?=
 =?us-ascii?Q?XNqZYLYMZzI1YviuRXMsUeDmnNDnyKw=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fb40ae-b78d-4ec9-a3a2-08da0dcdcd65
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 19:37:59.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlMkh+IA0Q+D7SbPRWSRE1xKGDgIzu/rspiHria8j2oSoaW0N940rHzlKhCEkEDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4000
X-Proofpoint-ORIG-GUID: UGFTJz9MSlHOmBrQgQINAj63W1foI-v3
X-Proofpoint-GUID: UGFTJz9MSlHOmBrQgQINAj63W1foI-v3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_06,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:42:31PM +0800, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Add two ipv6 address on underlay nic interface, and use bpf code to
> configure the secondary ipv6 address as the vxlan tunnel source ip.
> Then check ping6 result and log contains the correct tunnel source
> ip.
> 
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> ---
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_tunnel.sh    | 43 ++++++++++++++--
>  2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index ab635c55ae9b..56e1aee0ba5a 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -740,4 +740,55 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
>  	return TC_ACT_OK;
>  }
>  
> +SEC("ip6vxlan_set_tunnel_src")
> +int _ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
> +{
> +	struct bpf_tunnel_key key;
> +	int ret;
> +
> +	__builtin_memset(&key, 0x0, sizeof(key));
> +	key.local_ipv6[3] = bpf_htonl(0xbb); /* ::bb */
> +	key.remote_ipv6[3] = bpf_htonl(0x11); /* ::11 */
> +	key.tunnel_id = 22;
> +	key.tunnel_tos = 0;
> +	key.tunnel_ttl = 64;
> +
> +	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_TUNINFO_IPV6);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
> +SEC("ip6vxlan_get_tunnel_src")
> +int _ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
> +{
> +	char fmt[] = "key %d remote ip6 ::%x source ip6 ::%x\n";
> +	char fmt2[] = "label %x\n";
> +	struct bpf_tunnel_key key;
> +	int ret;
> +
> +	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_TUNINFO_IPV6);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_trace_printk(fmt, sizeof(fmt),
> +			 key.tunnel_id, key.remote_ipv6[3], key.local_ipv6[3]);
> +	bpf_trace_printk(fmt2, sizeof(fmt2),
> +			 key.tunnel_label);
Going back to the same comment on v1.

How is this printk used?
Especially for the most common test PASS case,
afaict, this will be ignored and left in the trace buffer?

Can it only printk when it detects error? like only print
when it fails the != 0xbb test case below?

Also, a nit, try to use bpf_printk() instead.

Some existing tunnel tests have printk but those are older examples
when test_progs.c was not ready.  In the future, we may want
to move these tunnel tests to test_progs.c where most of the tests
don't printk/grep also and use global variables or map to check and
only printF on unexpected values.  Thus, it may as well
have this new test steering into this direction in term
of only print on error.

> +
> +	if (bpf_ntohl(key.local_ipv6[3]) != 0xbb) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
> index b6923392bf16..4b7bf9c7bbe1 100755
> --- a/tools/testing/selftests/bpf/test_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> @@ -191,12 +191,15 @@ add_ip6vxlan_tunnel()
>  	ip netns exec at_ns0 ip link set dev veth0 up
>  	#ip -4 addr del 172.16.1.200 dev veth1
>  	ip -6 addr add dev veth1 ::22/96
> +	if [ "$2" == "2" ]; then
> +		ip -6 addr add dev veth1 ::bb/96
Testing $1 is not "::22" is as good as another $2 arg and
then $2 is not needed?

> +	fi
>  	ip link set dev veth1 up
>  
>  	# at_ns0 namespace
>  	ip netns exec at_ns0 \
>  		ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
> -		local ::11 remote ::22
> +		local ::11 remote $1
>  	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
>  	ip netns exec at_ns0 ip link set dev $DEV_NS up
>  
> @@ -231,7 +234,7 @@ add_ip6geneve_tunnel()
>  	# at_ns0 namespace
>  	ip netns exec at_ns0 \
>  		ip link add dev $DEV_NS type $TYPE id 22 \
> -		remote ::22     # geneve has no local option
> +		remote ::22    # geneve has no local option
Unnecessary space change.  Please try to avoid.  This distracts
the code review.

>  	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
>  	ip netns exec at_ns0 ip link set dev $DEV_NS up
>  
> @@ -394,7 +397,7 @@ test_ip6erspan()
>  
>  	check $TYPE
>  	config_device
> -	add_ip6erspan_tunnel $1
> +	add_ip6erspan_tunnel
What is this change for?
How is the patch set related to the test_ip6erspan()?

or it is an unrelated clean up? If it is, please use another patch
in its own cleanup patch set.

>  	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
>  	ping6 $PING_ARG ::11
>  	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> @@ -441,7 +444,7 @@ test_ip6vxlan()
>  
>  	check $TYPE
>  	config_device
> -	add_ip6vxlan_tunnel
> +	add_ip6vxlan_tunnel ::22 1
>  	ip link set dev veth1 mtu 1500
>  	attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
>  	# underlay
> @@ -690,6 +693,34 @@ test_vxlan_tunsrc()
>          echo -e ${GREEN}"PASS: ${TYPE}_tunsrc"${NC}
>  }
>  
> +test_ip6vxlan_tunsrc()
> +{
> +	TYPE=vxlan
> +	DEV_NS=ip6vxlan00
> +	DEV=ip6vxlan11
> +	ret=0
> +
> +	check $TYPE
> +	config_device
> +	add_ip6vxlan_tunnel ::bb 2
> +	ip link set dev veth1 mtu 1500
> +	attach_bpf $DEV ip6vxlan_set_tunnel_src ip6vxlan_get_tunnel_src
> +	# underlay
> +	ping6 $PING_ARG ::11
> +	# ip4 over ip6
> +	ping $PING_ARG 10.1.1.100
> +	check_err $?
> +	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
> +	check_err $?
> +	cleanup
> +
> +	if [ $ret -ne 0 ]; then
> +                echo -e ${RED}"FAIL: ip6${TYPE}_tunsrc"${NC}
> +                return 1
> +        fi
> +        echo -e ${GREEN}"PASS: ip6${TYPE}_tunsrc"${NC}
> +}
> +
>  attach_bpf()
>  {
>  	DEV=$1
> @@ -815,6 +846,10 @@ bpf_tunnel_test()
>  	test_vxlan_tunsrc
>  	errors=$(( $errors + $? ))
>  
> +	echo "Testing IP6VXLAN tunnel source..."
> +	test_ip6vxlan_tunsrc
> +	errors=$(( $errors + $? ))
> +
>  	return $errors
>  }
>  
> -- 
> 2.24.3 (Apple Git-128)
> 
