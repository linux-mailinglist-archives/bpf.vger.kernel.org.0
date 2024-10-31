Return-Path: <bpf+bounces-43644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3829B7C2B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE8F2826AC
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D119F135;
	Thu, 31 Oct 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgRTzceq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8F19C56F;
	Thu, 31 Oct 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382695; cv=none; b=LhA/J+Q8MU624gjvgHp8Z91Tj9dg4PkpELHdrVprRrl4qK58P1cz3avOVP6dlf2354YurDGVKPre8MCmkTh+bID10T6OIjpmFEOZ1yMMAr+YIyXQd7GaRnRR1BS35l9ihr7u0Y5HzEDTgfVjQgYItwJ5VN0nLIfZiXn5t79Hl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382695; c=relaxed/simple;
	bh=TRQt3loB1oMUTWM8eZBMkvgitPNFhDcwkGWbH1atc30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upLAMjEkQW+g1Jsq1TF6rmYcCVuNnxsMhrAPrk/xH3MiSWf9Dky9DdDdGZLFp5Wf2CmklDdULfqtEDFHRW2W7YRvrqcKbl+vXa3LYgdQFn4gdB/XqtdoZGyPTEYATjX7ud8V5NIOfY2e35PEISDBjbKVGYaYRa+VG7nvgq7iktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgRTzceq; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83aacecc8efso60545539f.0;
        Thu, 31 Oct 2024 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730382692; x=1730987492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEfuFOUUwUlNfpgXikX4P4KUS82Ha8vRgK1U6m+LTQQ=;
        b=AgRTzceqPPG6UDQ6BKubCnbenWPxnaGd1HOi9C/E6FU04OCGpWBQ69ZRUdA3POVeVc
         aGOVzIulLvbAZSpfXYbfyWX6Ub80xZgJjiB440FmaXy0keMJrkXuawoZDBHvhUo5r9ys
         PbYieGhXiQ3L8wPp0D9t3uBzAl9x3Ins9C6JGlwcdIfHDaFyuhZAk4/FQCHk9P+JZct+
         8QALz3InhS6S91KZTglcnjbTlWlFZ39iQbeedW7qtkcHcmpoI09aoAUjwPXIRMVsMDZm
         LH/oKYSYdHJfo69YiSI1LPzELAUJHSJaEQo8FMHhgEF8RJJIuYkfCvosMikJ03w4VqHh
         HWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382692; x=1730987492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEfuFOUUwUlNfpgXikX4P4KUS82Ha8vRgK1U6m+LTQQ=;
        b=sfDF9+pkl5gO04QYebttvVXnxUX9m4+qfVxuZxAXbu41W8kdSFy2vOOJrjUH31SvSX
         OGamfg32doCyCtx3x2IUZ2nCDplO/11cLe0X64PJgqX0jLJTy9jY1Dbeecy7CTemhuUR
         R6tf85bImlG1kGwup/iPQW/psAeyIzuAKOwIpro2MoKkSUcn+I+AwyooBNq5GTNtl9va
         1u7EEUJDXzf9yCjZyHc/d+Z8/xapVVDLwMbAjSOEhGw2kVwEqJww3e6v1fTnjEKl/aeT
         mJ4YVoWR8oFtOMJvf/hqSHOzDH2pyzWnDEcPdp14f5KBxybMPCFtcFD3E+YHla4FPUYp
         kNLA==
X-Forwarded-Encrypted: i=1; AJvYcCWfAKdTxNzYZ75P3zTCeJgahfl8dNJ6rvFQ6Hunh6oYnTAzvDPJuJTpqzengqbg/4XKVPg5NxFD@vger.kernel.org, AJvYcCXLkh1jpqlTyFY/CjDVDSRsQW00Q1ejb5juqhVsjzycxqPKlzoXIlS39+VCSd7EcM94gBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOja4gl1qi8NoOpncqKavpKk3NGcZrp87E2x8g/MsxO5zPI1hh
	e+qM43H7XfDjq4yfisv/fh5PImHFA0NUbhLs0N307BIYS3GsI6Shr+W/b+Wu97oCtiJiDoveafx
	kzJ3waYefphYFiO/tUKgltpGrcj4=
X-Google-Smtp-Source: AGHT+IFjqICxd2Y9JHQp8iJ9Or99pXmhjALcyMjij7WXJinBl9HyeRmf66tN5ioCRscgynBYyXxiocYwecGxNqt1jvg=
X-Received: by 2002:a05:6e02:13e9:b0:3a4:eab1:16f8 with SMTP id
 e9e14a558f8ab-3a6a94fa743mr14814745ab.11.1730382692224; Thu, 31 Oct 2024
 06:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 21:50:55 +0800
Message-ID: <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:30=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Oct 31, 2024 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 10/30/24 5:13 PM, Jason Xing wrote:
> > > > I realized that we will have some new sock_opt flags like
> > > > TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> > > > not... For each sock_opt point, they will be called without caring =
if
> > > > related flags in skb are set. Well, it's meaningless to add more
> > > > control of skb tsflags at each TS_xx_OPT_CB point.
> > > >
> > > > Am I understanding in a correct way? Now, I'm totally fine with thi=
s great idea!
> > > Yes, I think so.
> > >
> > > The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The a=
re only 3:
> > > SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I think=
 it would
> > > be quite wasteful to throw it away. ACK can be controlled by the
> > > TCP_SKB_CB(skb)->bpf_txstamp_ack.
> >
> > Right, let me try this:)
> >
> > > Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMPI=
NG)
> > > comment. I think it may as well go back to use the "u8
> > > bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() helpe=
r to
> > > enable/disable the timestamp related callback hook. May be add one
> > > BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.
> >
> > bpf_sock_ops_cb_flags this flag is only used in TCP condition, right?
> > If that is so, it cannot be suitable for UDP.
> >
> > I'm thinking of this solution:
> > 1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
> > include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflags
> > 2) flags =3D   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
> > SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> > 3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() or
> > in udp_sendmsg()
> > ...
> >
> > >
> > > For tx, one new hook should be at the sendmsg and should be around
> > > tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() which=
 should be
> >
> > I think there are two points we're supposed to record:
> > 1) the moment tcp/udp_sendmsg() is triggered. It represents the syscall=
 time.
> > 2) another point in tcp_tx_timestamp(). It represents the timestamp of
> > the last skb in this sendmsg() call.
> > Users may happen to send a big packet.
>
> Err on the side of fewer measurement points. It's always possible to
> add more later, but not possible to remove them (depending on whether
> BPF infra is ABI).
>
> Overall great suggestion. Thanks a lot for sharing your BPF expertise
> on this, Martin.
>
> On using the raw seqno: this data is accessible to anyone root in
> namespace (ns_capable) using packet sockets, so as long as it does not
> open to more than that, it is logically equivalent to the current
> setting.
>
> With seqno the BPF program has to be careful that the same seqno can
> be retransmitted, so for instance seeing an ACK before a (second) SND
> must be anticipated. That is true for SO_TIMESTAMPING today too.
>
> For datagrams (UDP as well as RAW and many non IP protocols), an
> alternative still needs to be found.

It seems that using the tskey for bpf extension is always correct and
easy to use.

Could we provide the tskey to users and then let users decide the
better way to identify the call of sendmsg. We could keep the
traditional use of tskey. If without it, people need to figure out a
good way and may find it difficult to use the bpf extension.

I will keep thinking of alternatives for UDP in the meantime.

Thanks,
Jason

