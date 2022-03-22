Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1E4E358D
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiCVAfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 20:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiCVAfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 20:35:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1006AA5A
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 17:33:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M0AfNO018816;
        Mon, 21 Mar 2022 17:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zFNOVqd2eO/lw1akSSWgBriPVE5NgTWXhG77UMHGIEo=;
 b=meRED/melDQBDo9aS+Gz7iv2M4/InzPRb7qKeAcDRb1QxKp2o2iSkrVxp8IFUQqAzxfS
 jsR9gZwyAQ38r+pVu1+B9aQ2hOFr8Ly3JDEO7HKy8ZYMfN8LgzueTvsL1toHUKKfmaAm
 /9fZDkuWMWBL+6Doq4HgjH61kkHbNskUdZM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewc9tp9q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 17:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbwkFHsmYZbtQTYvRB9Ka+jznWmQvc6pW6M86ztn70+v0fTMG1yFBGbOJRrNI635XQNp9Z8bqWPqeSJZ2rOxIwDfwbEtNGmUb3/sKHdE1CYUXo8du3vaBa+PeU4lfAdeZNW+qsYKTI6LqSSiYy5WktfZxJ98BxKhuCYrVd/s0VgR8xl/gyhzbipgVJB3Arjs7XGYp19Yt/X3EXuyH6UG//JoNtZMG+KIZVDGqytvT9B7ri/p6RVz1nsdeopIwgpybBE3LVNB9b6cpqtFybIeHg58BS9lfh6Q+uLJDMSnJJFS6iBQMi0V9aYx6x6mAWDRI3YS5l0kTA/Fd/APyCUkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFNOVqd2eO/lw1akSSWgBriPVE5NgTWXhG77UMHGIEo=;
 b=WqD0ug6w94y8s3MpyQmJULtf8Ppyj6Uoo8FBSFExzjsWMZbkaBkpoZ2VFdLDOgVDY59Oyw22b2N5bb5j4OVxRcqEpOcWuVpL66/ORekZdPWYGaOwtjCZjhhcnYiiRLUMhnWByH4jud1qddLRH+Lyvt7OfMpICT4hkXaGWngw+t/o+4wwsCkv6tC7PWIQJORCPfT3Hz24sie6vjBGR3/EINXkuWEaVZQFj2I+WE3JcmrLB69H0kcyxS4Hn7ahWmFPvaGK/isQDQrrjtCvSWelz/8p45RZ7UoX+WKs7YcoLC5Q9gW7C1fexYV5vzG5QeHowX6hkb8W26l2bYmWQcV8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by CH2PR15MB3608.namprd15.prod.outlook.com (2603:10b6:610:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 00:33:21 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5081.022; Tue, 22 Mar 2022
 00:33:21 +0000
Date:   Mon, 21 Mar 2022 17:33:17 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     fankaixi.li@bytedance.com
Cc:     john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add ipv6 vxlan tunnel source
 testcase
Message-ID: <20220322003317.m52ylgsw4xaivasx@kafai-mbp.dhcp.thefacebook.com>
References: <20220319130538.55741-1-fankaixi.li@bytedance.com>
 <20220319130538.55741-4-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319130538.55741-4-fankaixi.li@bytedance.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c5537b-6326-43bc-e2a4-08da0b9b914d
X-MS-TrafficTypeDiagnostic: CH2PR15MB3608:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB36081F9EF8D7F3C9264CD970D5179@CH2PR15MB3608.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfIB9+2+Sz2g4jWQS5I9X8OnPljy5LCbwIw/nmRMp052xwH+DJfOQ7zMQJIdOxwXj8gJDuKXNIA0dL6+q0x10yKsrTWaAvjjq3UBEhqw107QgDwBIGsTtCOfS/tw+eWK2ijiZG3OfG30DGZsAqhqR4Ma2YRnav4KSHJ3WGuh4SIlqf17gaPfTk68ghO6/n7I2uD4jJAPmr7tLCAYNOzksgXvBK0A+q4ns2k8txMGxWf7LVpnmNRlnolTQq6TltrnnEYuSs9ULFIufqHLEZveWGi/V5aP6xLfzlQSavm1nZy9XG7s9/G6GPtTHO4LmUf5yKryQBOeT25oX1NlYsiLjwcg9WfQpC0H9QwxB9mH/jFTjNNH3oh4rjfP+zUToPdI63jSw7UzQN5i2YzghH+ITJ15LEA1IO1vAgzDxHzUCmHlahlajLibrKl5oxxw3OK2M43Hj/NP4lRMYU6Sb5spIyYa0ROXlASwwPhEPlngR53f/DDtVkTzGnX+Kh06qcrSpWN759aJ2zZ1xhgAnuerXdodJxcXb2Ob6imEMXPSeGYJMIdZwcOwDhyt80RgfBzmXNFIF8exXR+R6hCT4NYLtP2VToSg2/OQICZ6fa71tJFSWG+OdeFbO+auaBCwS1B22hgjETPpM+TDUkt5XPxrWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(38100700002)(6506007)(4326008)(508600001)(8676002)(6512007)(9686003)(66556008)(66946007)(66476007)(83380400001)(6486002)(2906002)(8936002)(5660300002)(186003)(52116002)(86362001)(1076003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jt1IGAifWHrnhHwXk57Cx3VZfnszCZq7P8w2aF6DDSX/dYgnWSNYDJMUztXu?=
 =?us-ascii?Q?FNtQoSIpqXMojUoCmAYXxtD/9ksOU/sjDxdlG/UYNn8tyt6252Ze1rrototn?=
 =?us-ascii?Q?I1pPNRkJHC0y7nTUmWvvKOKr3wgneANJNhS1h2qKyXk2ulKTx5CmRSL+/fOz?=
 =?us-ascii?Q?ooWp70u0U1jBnbmOTogAMoNKjhrcXqXh3e+K+qQdZNq8MtoByCxEQJlx0Zjy?=
 =?us-ascii?Q?szGTrIyj4y4Zi0VahMTvb8q46MAk1p0MMtQDUxvBvI0ZS8hapJaTi1yMT9kw?=
 =?us-ascii?Q?P3KzBLFBMwoGhRRFbC11ah2h4IHU81jODV3XjASem4j9mYAclGnYsQ6mAqg5?=
 =?us-ascii?Q?PCy+4PO3jeX8dLL2HZ76TlWXscB/ISLIYnT5162Ja+wxVyIdqBG4Avp0vZdq?=
 =?us-ascii?Q?FXbmJu4rTm80f5KckwU3ngde1+vFarhWSLFcnvsMg1hfK/zsHJoDZ6LNpieI?=
 =?us-ascii?Q?NFLFdt7659VKS9jX+y7AYM04/W1LfxMbox6VqsFMee7okrmUGm2a8DlmdIrG?=
 =?us-ascii?Q?W8VWO4aUoMkDEisM4zOOH4wHiJ8aqaevGlBFe+XJlynKrxZTgri2e0aljx1a?=
 =?us-ascii?Q?J+XlEpfLinD/9b5LfQbW3yhfrYJrA6oTdeqH6lJj3E6jASqlntOxcrablVKG?=
 =?us-ascii?Q?U9UsL7DuSC+r5IZ1QnGjiL/nsAFCL1nJzDLSMSe0sWzdqdPzl+KuQlQz92LO?=
 =?us-ascii?Q?zyyWvZw8toB79f01Fp+DKAGQ00fbHqkxGBLy7QwSFPbOuzw3xpkeKFswfiwD?=
 =?us-ascii?Q?v+IF2CtXSbFfRotPXudXFQw79X/+uuVrQkyqgpFQxzpEAanZIRuCkVfvq0zd?=
 =?us-ascii?Q?O299rOOc3Xnh+ojvmFFqzYPqx4yuYjltwV0ylgqPKhzp2RWLP+O5F0JrLqmh?=
 =?us-ascii?Q?V2hz77FCn06ZTzyRkw/K0E/QGDNRrUbFIP/eEOSAgwyY4A5yV5WGIKf3c5dz?=
 =?us-ascii?Q?DJ4P6UlBPh4m97U7TmZ50RKmuzJmDVceRO2IyTSujj/xxYRvSsp9zJxGHA73?=
 =?us-ascii?Q?VGymfuvVWtdlAm+HstVX+kug2kKk0wmgoYfPnugsqnaKWWiahpFS01NnBeP+?=
 =?us-ascii?Q?CWThPIG9LWzOvDOQIKKCAMSKexrCngpBfYJJTvrK2MNPjR4s14QA+qx3yty1?=
 =?us-ascii?Q?dv4wcukzjo5MZHHhBQxOBL+peD99FzH3ndVRIBD9Q/nDDWJRIXCsjLEjm1IB?=
 =?us-ascii?Q?D4dqMTwBewDNz9pl+gV1rCHwfNK2J+zbxSerbJ/FnJ+8/+mAZO72gcVb7n7z?=
 =?us-ascii?Q?2dwUmyH5O7GZnoLaSU+hiYh0ynSNGg1vkDP5Ivp7VBqAirw0iE+nMGXzC3qA?=
 =?us-ascii?Q?mfbQMvQ0QGkgOZ0/d0BRJtRtzLxzrjiUIVrtkkBpspipOn/FoTkoNykjGUs3?=
 =?us-ascii?Q?apXI8lD5YG91Zwyiy/4F5qh3S58GO5WJv+PezMZ9cWIO2g1LymJnf+z94qtW?=
 =?us-ascii?Q?Fnwqx3xFxVa/HzFh5sDeyBiYnTtAtSDyKtSxlIoL4A2fjYb41sJWNw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c5537b-6326-43bc-e2a4-08da0b9b914d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 00:33:21.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfINRLqbZS6wQiADF9zKSvl1+7Tx49psMa1na01JHRm9+dpq5cgYYhWrb44DjRwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3608
X-Proofpoint-ORIG-GUID: n-H_dJo28rHA9W-fWH9JBhGeE-U3nBJY
X-Proofpoint-GUID: n-H_dJo28rHA9W-fWH9JBhGeE-U3nBJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_10,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 19, 2022 at 09:05:38PM +0800, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Add two ipv6 address on underlay nic interface, and use bpf code to
> configure the secondary ipv6 address as the vxlan tunnel source ip.
> Then check ping6 result and log contains the correct tunnel source
> ip.
> 
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> ---
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 46 ++++++++++++
>  tools/testing/selftests/bpf/test_tunnel.sh    | 71 +++++++++++++++----
>  2 files changed, 105 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 4a39556ef609..67cb7ca3e083 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -736,4 +736,50 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
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
How is the printk output used?  Is the output text verified in the
test_tunnel.sh?
Can the values be checked in the bpf prog itself to avoid the printk?

The same goes for the patch 2.

> +
> +	return TC_ACT_OK;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
> index 62ef5c998b6a..a0f9a5c5e0a5 100755
> --- a/tools/testing/selftests/bpf/test_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> @@ -67,6 +67,11 @@ add_second_ip()
>    ip addr add dev veth1 172.16.1.20/24
>  }
>  
> +add_second_ip6()
> +{
> +  ip addr add dev veth1 ::bb/96
> +}
> +
>  add_gre_tunnel()
>  {
>  	# at_ns0 namespace
> @@ -94,7 +99,7 @@ add_ip6gretap_tunnel()
>  	# at_ns0 namespace
>  	ip netns exec at_ns0 \
>  		ip link add dev $DEV_NS type $TYPE seq flowlabel 0xbcdef key 2 \
> -		local ::11 remote ::22
> +		local ::11 remote $REMOTE_IP6
>  
>  	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
>  	ip netns exec at_ns0 ip addr add dev $DEV_NS fc80::100/96
> @@ -143,7 +148,7 @@ add_ip6erspan_tunnel()
>  	if [ "$1" == "v1" ]; then
>  		ip netns exec at_ns0 \
>  		ip link add dev $DEV_NS type $TYPE seq key 2 \
> -		local ::11 remote ::22 \
> +		local ::11 remote $REMOTE_IP6 \
afaict, only add_ip6vxlan_tunnel needs something other than ::22,
so this and other similar code churns is not necessary?

>  		erspan_ver 1 erspan 123
>  	else
>  		ip netns exec at_ns0 \
> @@ -196,7 +201,7 @@ add_ip6vxlan_tunnel()
>  	# at_ns0 namespace
>  	ip netns exec at_ns0 \
>  		ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
> -		local ::11 remote ::22
> +		local ::11 remote $REMOTE_IP6
Can it be an optional argument instead and default to ::22 ?

Also, using $1 is as good?

[ ... ]

> +test_ip6vxlan_tunsrc()
> +{
> +	TYPE=vxlan
> +	DEV_NS=ip6vxlan00
> +	DEV=ip6vxlan11
> +	REMOTE_IP6=::bb
> +	ret=0
> +
> +	check $TYPE
> +	config_device
> +	add_second_ip6
> +	add_ip6vxlan_tunnel $REMOTE_IP6
here.  It seems most of the patch needs is
	add_ip6vxlan_tunnel '::bb'

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
> +                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
> +                return 1
> +        fi
> +        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
> +}
> +
>  attach_bpf()
>  {
>  	DEV=$1
> @@ -818,6 +860,11 @@ bpf_tunnel_test()
>  	test_vxlan_tunsrc
>  	errors=$(( $errors + $? ))
>  
> +
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
