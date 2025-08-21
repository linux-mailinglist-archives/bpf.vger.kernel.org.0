Return-Path: <bpf+bounces-66199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A73B2F7FA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2D170D6A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A930FF06;
	Thu, 21 Aug 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiaaPxYJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F2E091D
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779393; cv=none; b=JotQjrKkjswAIywCifzXrEXD92P8kbnxbHvbPhx8OE/fCElxHge2Z/fNn/zOigW3YK3ROxZm02ncYEjvswoq9wXVRBwhyD2ZrnLLdPu5jrAt/eh/rfaox10B8XehQY3Sx3PZ+vVl5bNahYCytERzEYenGEgtVxnujuaknjNua5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779393; c=relaxed/simple;
	bh=zkDbxvo7pdEoYH6PpNr9aonByAeBiVU4hVH0AT2E4j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3nKj7gXnb4QtSbVFoM7pJIv3ffAHTk8cOETIvq97bu+jtfTrp1i7ZRHnKSk3dzIevIf49sXCuWtFidECsDiEgtitFXfgyjDjDgXhwW9l1Ck30bnUk1nJEatR7RMpvijoHvMWaKWBYP8a1F4GdG54pAXrIFcrS437iGDHmY0aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiaaPxYJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso9976191cf.3
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755779390; x=1756384190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMyf7TUTcVlmFShDFbUR03mYlUdBmR7tL66qjPszynQ=;
        b=XiaaPxYJ9KsUdsZ31BNVF9RoGzGI+oG8SXeJNgH8C2WS3D6F+qxqkjlbF+kKCZcNqn
         k1yU+lXbKFQCK2j2HOP2gO5xGGgqcYLXEYunyppSA8bz/JmgOssllQSWyN5CZkaqyC50
         oZDAHAmVALsWyUp5MeIFxBngn/fABw7QHTG8fGNnJMG9/TF9SGzmnQH535aDkA8ksAng
         UzGRVYIMbMCLAsgeUBDk8qDzUjx+ulDMmJ6gYbZRTE2GxKy4h+OoxTa57QHA3RF+VYwx
         CZncZayiMWgSg0hzlvGNgGq9NN8GjeBoSFzedGDZHF7t8e3MECY1NUHZ4FnMWUv+vLRc
         lbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779390; x=1756384190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMyf7TUTcVlmFShDFbUR03mYlUdBmR7tL66qjPszynQ=;
        b=SjlRbI2EWmc4KuTR8M6a8Gl26NrYWGDREGRDcMlwrldpraHEizxMv4TTufZSzvvuid
         2ZJlZfxjfyZm6QQ1brAxmZP8yKHdUL11/mhsmT655tY2/r7AWrgqvjN9WZG/YxhT6oVK
         F09NnyfnHFo7B9XxLhAqLx/8V/eAoEonJhftZ3P3v5inwz+7nW7Q2W/am7bjRW+uNWGJ
         lvFeHM7+f5Dd/eTwx/67IGFhDLViEQ/jx2/16g1sD6OWsYJS9erLHOA7rq+1AHWIne0p
         eZJTer2jb06bJoCXpjY07owJ1tYCU8/6SgkI/Ti5magVeDQa5TpeLzQxzQPNo7fzLLt8
         /lxw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1J4w/5HcSXYTb6+53E86V7zj1if43m2ac3EpVUoEx20+A+MIeHKI9xPr/1cxxHhwuOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/S8ltowCWpO0Sd3dPrUpotpVmuQGjUptze3YHlmHj7yUBMmRv
	cQ4RyehgYy5pv6XfyytjLqckTvd1fr+mVS+lz61C9VQgzDMvdj6bcCx5Jep5TdlQ8u999BVzCDz
	JET2skch8ophhwK+nXPz9HYOfWD4ckG92N4IAoapg
X-Gm-Gg: ASbGnctyVmJKCcX3UJ0xyWisNXWda5F1gl2Te2Y1A3fEQJWgFzlnEAISSTVEe3/2TA9
	BKfwdgPKQemndSBPofT/eq+T8cClFShF+Pc6w15x/ZrKDcndfUx++vjLwHMcFA5cYc5LmCwIFCG
	EvvA41vdZ+xvxNzZlWtZrQ1h3mtWYQ6YMxU9AWvA+K8y3v5lgJP96eE8DUaakMV3M3mjyAcws2j
	IwyoeUbmpZfrwH0OFWv+dEAxA==
X-Google-Smtp-Source: AGHT+IGiDTu4Nx/S2i7PXKBQcL0zSflTE4ZdcC1UihTgHSCzCGsNJVk9lvVSiXeTSusqav8nRJ0XJpzvxKMBN8t/Gxk=
X-Received: by 2002:a05:622a:242:b0:4b2:9c3d:bc4c with SMTP id
 d75a77b69052e-4b29fa6dac9mr26388591cf.33.1755779389674; Thu, 21 Aug 2025
 05:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:29:38 -0700
X-Gm-Features: Ac12FXwtX6Y71JLad1BL80WdVtDYKWVSK_UzOY3Wd_laWGj2k0iPGrLqT8yKhgM
Message-ID: <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The Accurate ECN allows echoing back the sum of bytes for
> each IP ECN field value in the received packets using
> AccECN option. This change implements AccECN option tx & rx
> side processing without option send control related features
> that are added by a later change.
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> (Some features of the spec will be added in the later changes
> rather than in this one).
>
> A full-length AccECN option is always attempted but if it does
> not fit, the minimum length is selected based on the counters
> that have changed since the last update. The AccECN option
> (with 24-bit fields) often ends in odd sizes so the option
> write code tries to take advantage of some nop used to pad
> the other TCP options.
>
> The delivered_ecn_bytes pairs with received_ecn_bytes similar
> to how delivered_ce pairs with received_ce. In contrast to
> ACE field, however, the option is not always available to update
> delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
> bytes calculated based on the cumulative ACK+SACK information
> are assigned to one of the counters using an estimation
> heuristic to select the most likely ECN byte counter. Any
> estimation error is corrected when the next AccECN option
> arrives. It may occur that the heuristic gets too confused
> when there are enough different byte counter deltas between
> ACKs with the AccECN option in which case the heuristic just
> gives up on updating the counters for a while.
>
> tcp_ecn_option sysctl can be used to select option sending
> mode for AccECN: TCP_ECN_OPTION_DISABLED, TCP_ECN_OPTION_MINIMUM,
> and TCP_ECN_OPTION_FULL.
>
> This patch increases the size of tcp_info struct, as there is
> no existing holes for new u32 variables. Below are the pahole
> outcomes before and after this patch:
>
> [BEFORE THIS PATCH]
> struct tcp_info {
>     [...]
>      __u32                     tcpi_total_rto_time;  /*   244     4 */
>
>     /* size: 248, cachelines: 4, members: 61 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_info {
>     [...]
>     __u32                      tcpi_total_rto_time;  /*   244     4 */
>     __u32                      tcpi_received_ce;     /*   248     4 */
>     __u32                      tcpi_delivered_e1_bytes; /*   252     4 */
>     __u32                      tcpi_delivered_e0_bytes; /*   256     4 */
>     __u32                      tcpi_delivered_ce_bytes; /*   260     4 */
>     __u32                      tcpi_received_e1_bytes; /*   264     4 */
>     __u32                      tcpi_received_e0_bytes; /*   268     4 */
>     __u32                      tcpi_received_ce_bytes; /*   272     4 */
>
>     /* size: 280, cachelines: 5, members: 68 */
> }
>
> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> group size of tcp_sock_write_rx is increased from 96 to 112. Below
> are the pahole outcomes before and after this patch:
>
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4; /*  2522: 0  1 */
>     u8                         unused2:4;             /*  2522: 4  1 */
>     /* XXX 1 byte hole, try to pack */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;    /*  2668     4 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];      /*  2728     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 167 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4;/*  2522: 0  1 */
>     u8                         unused2:4;            /*  2522: 4  1 */
>     u8                         accecn_minlen:2;      /*  2523: 0  1 */
>     u8                         est_ecnfield:2;       /*  2523: 2  1 */
>     u8                         unused3:4;            /*  2523: 4  1 */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;   /*  2668     4 */
>     u32                        delivered_ecn_bytes[3];/*  2672    12 */
>     /* XXX 4 bytes hole, try to pack */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];     /*  2744     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 171 */
> }
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v13
> - Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
>   TCP_ACCECN_CEB_INIT_OFFSET to this patch
> - Use static array lookup in tcp_accecn_optfield_to_ecnfield()
> - Return false when WARN_ON_ONCE() is true in tcp_accecn_process_option()
> - Make synack_ecn_bytes as static const array and use const u32 pointer
>   in tcp_options_write()
> - Use ALIGN() and ALIGN_DOWN() in tcp_options_fit_accecn() to pad TCP Acc=
ECN
>   option to dword
>
> v10
> - Add documentation of tcp_ecn_option in ip-sysctl.rst to this patch
> - Remove the global variable u32 synack_ecn_bytes[3]
> - Add READ_ONCE() over every reads of sysctl
>
> v9:
> - Restruct the code in the for loop of tcp_accecn_process_option()
> - Remove ecn_bytes and add use_synack_ecn_bytes flag in tcp_out_options
>   struct to identify whether syn_ack_bytes or received_ecn_bytes is used
> - Replace leftover_bytes and leftover_size with leftover_highbyte and
>   leftover_lowbyte and add comments in tcp_options_write()
>
> v8:
> - Reset leftover_size to 2 once leftover_bytes is used
> ---
>  Documentation/networking/ip-sysctl.rst        |  19 ++
>  .../networking/net_cachelines/tcp_sock.rst    |   3 +
>  include/linux/tcp.h                           |   9 +-
>  include/net/netns/ipv4.h                      |   1 +
>  include/net/tcp.h                             |  13 ++
>  include/net/tcp_ecn.h                         |  89 +++++++++-
>  include/uapi/linux/tcp.h                      |   7 +
>  net/ipv4/sysctl_net_ipv4.c                    |   9 +
>  net/ipv4/tcp.c                                |  15 +-
>  net/ipv4/tcp_input.c                          |  94 +++++++++-
>  net/ipv4/tcp_ipv4.c                           |   1 +
>  net/ipv4/tcp_output.c                         | 165 +++++++++++++++++-
>  12 files changed, 412 insertions(+), 13 deletions(-)
>


             minlen);
> +               }
>         }
>  }
>
> @@ -263,6 +347,9 @@ static inline void tcp_accecn_init_counters(struct tc=
p_sock *tp)
>         tp->received_ce =3D 0;
>         tp->received_ce_pending =3D 0;
>         __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
> +       __tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +       tp->accecn_minlen =3D 0;
> +       tp->est_ecnfield =3D 0;
>  }
>
>  /* Used for make_synack to form the ACE flags */
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index bdac8c42fa82..53e0e85b52be 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -316,6 +316,13 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> +       __u32   tcpi_received_ce;    /* # of CE marks received */
> +       __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
> +       __u32   tcpi_delivered_e0_bytes;
> +       __u32   tcpi_delivered_ce_bytes;
> +       __u32   tcpi_received_e1_bytes;
> +       __u32   tcpi_received_e0_bytes;
> +       __u32   tcpi_received_ce_bytes;
>  };
>

We do not add more fields to tcp_info, unless added fields are a
multiple of 64 bits.

Otherwise a hole is added and can not be recovered.

