Return-Path: <bpf+bounces-49573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF9A1A1AE
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 11:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDEF161E17
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1C20DD68;
	Thu, 23 Jan 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEmZlgSO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4580034;
	Thu, 23 Jan 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627363; cv=none; b=iV/gDGjUG3XeNycFdUS6LZXcasNlbaAaARYf8n82/USZHQUNKnIp1MXzQfWx8dYZ8aZi4f91N25B/pMdaCnLXwTvV9ChziFWGhc4Gd34YsjlBMc/XM0fN7Wn3Za9UOD0g3JJ59oQLEqggPCaNS34mqpPHBYqJ6P87XlcLyGK7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627363; c=relaxed/simple;
	bh=rixaremibsdpomPxEDOJ2G4m0tMWa20Q0KMpOuwD6Vo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1XDmcc2TItiD/Iv0CbotFRo6VUl7Xuj5/qQ02huxYVUln8fM+WlypsmD3uCM5k2/DNE4KRoayo9TcxQ8yN+zWkx5LfrL2Db8j6DO9FTgdKHWluVCxFh25j5iM6wZ4rgrm6RAoWPrdAIfUAe23lxuP2mHqvvcQPr6MmezRyl5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEmZlgSO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7X1V7028144;
	Thu, 23 Jan 2025 10:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e0vwn7
	hlQTbpftcEXabrwZN2kpU3cCFQ0ZuBU9vEIxY=; b=lEmZlgSOQr6s93xXyLe0TK
	ofG2jBkJaxtC3j3EI2H+f8ta6noZYt6l5D4QFQYL9KKX+xfzsLjBCRLa6zGKj+7S
	RfDdNq+VDat20px3tnBElpDoSxqIm3k9FUhUPSOJ1GARON6JtAVRYA2nBfbGNUbb
	yaKjBu1xBzNburD6tuxOMoGSZEHcmWRpGvGLfmU5JUWA5ClZw2kJGzdSfsYf8+au
	Gka3Ib1KK/h4B1rObEAPLbbdJsHi9VXzH+5JkJVnjJE/1ezTBcum/C2D+dRBNqPp
	P4VjgvbNGdXtAh4Ov/pWwqAge1A1Z9mPxA3IVsOAmTJIrDWkpL4WdSa3boRY0Z3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bhfpgr61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:15:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50NA16ju007555;
	Thu, 23 Jan 2025 10:15:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bhfpgr5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:15:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7LLF9022370;
	Thu, 23 Jan 2025 10:15:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kcwhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:15:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NAFNsY18743570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:15:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54964201F4;
	Thu, 23 Jan 2025 10:15:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC80201F3;
	Thu, 23 Jan 2025 10:15:22 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 10:15:22 +0000 (GMT)
Message-ID: <6685f9266702dcf0a3123f9be7c1c0200a5f4032.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 3/6] net/smc: Introduce generic hook smc_ops
From: Gerd Bayer <gbayer@linux.ibm.com>
To: dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
        sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org
Date: Thu, 23 Jan 2025 11:15:21 +0100
In-Reply-To: <20250123073034.GQ89233@linux.alibaba.com>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
	 <20250123015942.94810-4-alibuda@linux.alibaba.com>
	 <20250123073034.GQ89233@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xpw2aMzWgd0bXPpX3HPr6tD8LZyGFdCF
X-Proofpoint-ORIG-GUID: KS02G5endOtvMiB0MAJCcBckEQIyh6t0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230072

On Thu, 2025-01-23 at 15:30 +0800, Dust Li wrote:
> On 2025-01-23 09:59:39, D. Wythe wrote:
> > The introduction of IPPROTO_SMC enables eBPF programs to determine
> > whether to use SMC based on the context of socket creation, such as
> > network namespaces, PID and comm name, etc.
> >=20
> > As a subsequent enhancement, to introduce a new generic hook that
> > allows decisions on whether to use SMC or not at runtime, including
> > but not limited to local/remote IP address or ports.
> >=20
> > Moreover, in the future, we can achieve more complex extensions to the
> > protocol stack by extending this ops.
> >=20
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > ---
> > include/net/netns/smc.h |  3 ++
> > include/net/smc.h       | 53 ++++++++++++++++++++++++
> > net/ipv4/tcp_output.c   | 18 +++++++--
> > net/smc/Kconfig         | 12 ++++++
> > net/smc/Makefile        |  1 +
> > net/smc/smc_ops.c       | 53 ++++++++++++++++++++++++
> > net/smc/smc_ops.h       | 28 +++++++++++++
> > net/smc/smc_sysctl.c    | 90 +++++++++++++++++++++++++++++++++++++++++
> > 8 files changed, 254 insertions(+), 4 deletions(-)
> > create mode 100644 net/smc/smc_ops.c
> > create mode 100644 net/smc/smc_ops.h
> >=20
> > diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> > index fc752a50f91b..81b3fdb39cd2 100644
> > --- a/include/net/netns/smc.h
> > +++ b/include/net/netns/smc.h
> > @@ -17,6 +17,9 @@ struct netns_smc {
> > #ifdef CONFIG_SYSCTL
> > 	struct ctl_table_header		*smc_hdr;
> > #endif
> > +#if IS_ENABLED(CONFIG_SMC_OPS)
> > +	struct smc_ops __rcu		*ops;
> > +#endif /* CONFIG_SMC_OPS */
> > 	unsigned int			sysctl_autocorking_size;
> > 	unsigned int			sysctl_smcr_buf_type;
> > 	int				sysctl_smcr_testlink_time;
> > diff --git a/include/net/smc.h b/include/net/smc.h
> > index db84e4e35080..844f98a6296a 100644
> > --- a/include/net/smc.h
> > +++ b/include/net/smc.h
> > @@ -18,6 +18,8 @@
> > #include "linux/ism.h"
> >=20
> > struct sock;
> > +struct tcp_sock;
> > +struct inet_request_sock;
> >=20
> > #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
> >=20
> > @@ -97,4 +99,55 @@ struct smcd_dev {
> > 	u8 going_away : 1;
> > };
> >=20
> > +#define  SMC_OPS_NAME_MAX 16
> > +
> > +enum {
> > +	/* ops can be inherit from init_net */
> > +	SMC_OPS_FLAG_INHERITABLE =3D 0x1,
> > +
> > +	SMC_OPS_ALL_FLAGS =3D SMC_OPS_FLAG_INHERITABLE,
> > +};
> > +
> > +struct smc_ops {
> > +	/* priavte */
> > +
> > +	struct list_head list;
> > +	struct module *owner;
> > +
> > +	/* public */
> > +
> > +	/* unique name */
> > +	char name[SMC_OPS_NAME_MAX];
> > +	int flags;
> > +
> > +	/* Invoked before computing SMC option for SYN packets.
> > +	 * We can control whether to set SMC options by returning varios valu=
e.
> > +	 * Return 0 to disable SMC, or return any other value to enable it.
> > +	 */
> > +	int (*set_option)(struct tcp_sock *tp);
> > +
> > +	/* Invoked before Set up SMC options for SYN-ACK packets
> > +	 * We can control whether to respond SMC options by returning varios
> > +	 * value. Return 0 to disable SMC, or return any other value to enabl=
e
> > +	 * it.
> > +	 */
> > +	int (*set_option_cond)(const struct tcp_sock *tp,
> > +			       struct inet_request_sock *ireq);
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_SMC_OPS)
> > +#define smc_call_retops(init_val, sk, func, ...) ({	\
> > +	typeof(init_val) __ret =3D (init_val);		\
> > +	struct smc_ops *ops;				\
> > +	rcu_read_lock();				\
> > +	ops =3D READ_ONCE(sock_net(sk)->smc.ops);		\
> > +	if (ops && ops->func)				\
> > +		__ret =3D ops->func(__VA_ARGS__);		\
> > +	rcu_read_unlock();				\
> > +	__ret;						\
> > +})
> > +#else
> > +#define smc_call_retops(init_val, ...) (init_val)
> > +#endif /* CONFIG_SMC_OPS */
> > +
> > #endif	/* _SMC_H */
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 0e5b9a654254..f62e30b4ffc8 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -40,6 +40,7 @@
> > #include <net/tcp.h>
> > #include <net/mptcp.h>
> > #include <net/proto_memory.h>
> > +#include <net/smc.h>
> >=20
> > #include <linux/compiler.h>
> > #include <linux/gfp.h>
> > @@ -759,14 +760,18 @@ static void tcp_options_write(struct tcphdr *th, =
struct tcp_sock *tp,
> > 	mptcp_options_write(th, ptr, tp, opts);
> > }
> >=20
> > -static void smc_set_option(const struct tcp_sock *tp,
> > +static void smc_set_option(struct tcp_sock *tp,
> > 			   struct tcp_out_options *opts,
> > 			   unsigned int *remaining)
> > {
> > #if IS_ENABLED(CONFIG_SMC)
> > +	struct sock *sk =3D &tp->inet_conn.icsk_inet.sk;
> > 	if (static_branch_unlikely(&tcp_have_smc)) {
> > 		if (tp->syn_smc) {
> > -			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> > +			tp->syn_smc =3D !!smc_call_retops(1, sk, set_option, tp);
> > +			/* re-check syn_smc */
> > +			if (tp->syn_smc &&
> > +			    *remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> > 				opts->options |=3D OPTION_SMC;
> > 				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
> > 			}
> > @@ -776,14 +781,19 @@ static void smc_set_option(const struct tcp_sock =
*tp,
> > }
> >=20
> > static void smc_set_option_cond(const struct tcp_sock *tp,
> > -				const struct inet_request_sock *ireq,
> > +				struct inet_request_sock *ireq,
> > 				struct tcp_out_options *opts,
> > 				unsigned int *remaining)
> > {
> > #if IS_ENABLED(CONFIG_SMC)
> > +	const struct sock *sk =3D &tp->inet_conn.icsk_inet.sk;
> > 	if (static_branch_unlikely(&tcp_have_smc)) {
> > 		if (tp->syn_smc && ireq->smc_ok) {
> > -			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> > +			ireq->smc_ok =3D !!smc_call_retops(1, sk, set_option_cond,
> > +							 tp, ireq);
> > +			/* re-check smc_ok */
> > +			if (ireq->smc_ok &&
> > +			    *remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> > 				opts->options |=3D OPTION_SMC;
> > 				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
> > 			}
> > diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> > index ba5e6a2dd2fd..27f35064d04c 100644
> > --- a/net/smc/Kconfig
> > +++ b/net/smc/Kconfig
> > @@ -33,3 +33,15 @@ config SMC_LO
> > 	  of architecture or hardware.
> >=20
> > 	  if unsure, say N.
> > +
> > +config SMC_OPS
> > +	bool "Generic hook for SMC subsystem"
> > +	depends on SMC && BPF_SYSCALL
> > +	default n
> > +	help
> > +	  SMC_OPS enables support to register generic hook via eBPF programs
> > +	  for SMC subsystem. eBPF programs offer much greater flexibility
> > +	  in modifying the behavior of the SMC protocol stack compared
> > +	  to a complete kernel-based approach.
> > +
> > +	  if unsure, say N.
>=20
> I'm still not completely satisfied with the name smc_ops. Since this
> will be the API for our users, we need to be carefull on the name.

If I may jump in with a suggestion here:
On my first glance, I'd expect SMC_OPS to offer OPS as a general API.
The description however suggest that this adds "contol points" or hooks
in the SMC code, that eBPF programs can use to tweak the protocol's
behavior. Exclusively eBPF programs, it seems.

So how about naming this SMC_EBPF_HOOKS or SMC_EBPF_SUPPORT?

Just my 2ct,
Gerd

>=20
> It seems like you're aiming to define a common set of operations, but
> the implementation appears to be intertwined with BPF. If this is
> intended to be a common interface, and if we are using another operation,
> there shouldn=E2=80=99t be a need to hold a BPF reference.
>=20
> As your 'help' sugguest, What about smc_hook ?
>=20
> Best regards,
> Dust
>=20
>=20


