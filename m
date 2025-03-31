Return-Path: <bpf+bounces-54949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B8A76289
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710D5166B2F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4271D6DBC;
	Mon, 31 Mar 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e355AXQr"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E5142900;
	Mon, 31 Mar 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410258; cv=pass; b=GRCK95/qYCUeYdIYvyr4mxClZBEtg4wAd6xhxSS+EF/eCcIdJKV29WfLHeh03zQlD700QPJ9xfLrW0uWrO0dD7JHZijbgCN8GexZGwOXaZA0u5kvkmne9E8Y4ZgH8GP0Lb+L93E3wtc96KOT4P3NcVukG9IJnf9piiRXxSwObnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410258; c=relaxed/simple;
	bh=H9Dv6zHFoOfkNPb48Z/rEqNtZQCA8F7k2FEyTJooeqo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gf7xPF/0e7UyHpOVoRnlb9Nipyb9Yc5lbMhxNFpBo+cK2GigLzHP423p762XAPlRIfelfsVB/DA7kf8O4MVn6oZCFnaVcRQSMfDNY25iq7cF59YIZnpvWls2+z//lb4dN9FLeFn6rOKpqH9ncpZ1u3COtjj6eQKZQ2BNAoqd7Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e355AXQr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [127.0.0.1] (unknown [193.138.7.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZR4J83vjwz49Q0n;
	Mon, 31 Mar 2025 11:37:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743410249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftu6Ca8PxJX4/bWOkVggbgzlv2SRHX4J5kcFhu65I10=;
	b=e355AXQr+mAfc/77Dt3aXP87cCVeG5IIv341nMs+GGiyaYa7QNhM5O2nAOM/TjoDSGltrx
	OXc0VBL3c3+KjK+hOr7ltdb0hI37b5HB7T/Q4r8bLgexsnXPXyQBYTNYLQ0AnQPVBUPFlb
	EOksiAKXUhNhxsSHhDXtsHx1l6eMp8n/R80oZ5Ek2Qj73UWrloGGYerVjzONwvUYayiIql
	b6wPpNwuJT0vPvas0UmMiEw0WH4JanWqsdPtyRAxCkf0LQ2fdfdpKnVLf363z4AWbDPUyR
	DD8L0KVS41DkS1JwTIclrl7aErEBvqppIEB7WFIrZ/46UFXDtRUjjSxkiPEAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743410249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftu6Ca8PxJX4/bWOkVggbgzlv2SRHX4J5kcFhu65I10=;
	b=El220epuTaZol6fH8HGMM3JxGOXL1SQBVmtp1vOXNdNaSC6zYPgXfJE52Gxml1Xb3d+q7W
	2klhVR6jk9MlrEjY9bAUmWcO2s00fnmH4GAquYLzzN2njNSYAPQcfnXsZpYrue/wj/ETJB
	PSr9f5FbpdFEs7NPQvlAyIW4XMuKKRYninO1WFj/QdedKyoEbCAN2CVyMiNwpaD/iruhSm
	JEvXZjTeAURVqqeqvMZ9N3mG02XMSj2xvh7czJyo2UHHi7xogCR/5SNNMMN2uB30QxIZs/
	T1joPLEkDtwDb/Y6vVotXhQFQTnL9QdCi3W7ETOOEKlb8JWSt0QuTh/XuRt2/A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743410249; a=rsa-sha256;
	cv=none;
	b=c0OvtlU7IXpEVUqI4LACxL12laPtjwtetFKlmTr/PbggwY/gijZ+/wUe5V009pOWFNwOix
	425UoN53TI33MSHRdnhI6q/ileG3wt63yWsFt66cbTM3wx3S7OaMBGbAlkEZG33DZlpOOJ
	mAt1gQcSIDL0fj2uLjiyv+a2ZmjfauHT2efroQsVFbNMGBZYVnVrmc4Mfi6+FuKXiptlVg
	ZtWQKQwyLUQ7RAKE03LJW6Ai0ArrYjzIRpzshsq0erBnDxoKnBLuMZB8jtVCYd/Ze8vB8b
	3A72++abLZt9fMYgPfTzp3PFNfY2GxUMAwLkM9p9bq4aNIKQMvL+oZ+Xs14zTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Date: Mon, 31 Mar 2025 11:37:29 +0300
From: Pauli Virtanen <pav@iki.fi>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, Martin KaFai Lau <martin.lau@linux.dev>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/3=5D_bpf=3A_TSTAMP=5FCOMPLETION=5FC?=
 =?US-ASCII?Q?B_timestamping_+_enable_it_for_Bluetooth?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL+tcoAvFCm9xCOwCLAp18JpT-JBzXQ2yziTZvO8QvZdL5gRZw@mail.gmail.com>
References: <cover.1743337403.git.pav@iki.fi> <CAL+tcoAvFCm9xCOwCLAp18JpT-JBzXQ2yziTZvO8QvZdL5gRZw@mail.gmail.com>
Message-ID: <1F98E20C-2F0D-4B3F-8DBE-3F0C44FCC65D@iki.fi>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

31=2E maaliskuuta 2025 3=2E39=2E46 GMT+03:00 Jason Xing <kerneljasonxing@g=
mail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Sun, Mar 30, 2025 at 8:23=E2=80=AFPM Pauli Virtanen <pav@iki=2Efi> wro=
te:
>>
>> Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB and emit it on completion
>> timestamps=2E
>>
>> Enable that for Bluetooth=2E
>
>Thanks for working on this!
>
>It would be better if you can cc Martin in the next revision since he
>is one of co-authors of BPF timestamping=2E Using
>=2E/scripts/get_maintainer=2Epl will show you which group people you're
>supposed to cc=2E
>
>>
>> Tests:
>> https://lore=2Ekernel=2Eorg/linux-bluetooth/a74e58b9cf12bc9c64a024d18e6=
e58999202f853=2E1743336056=2Egit=2Epav@iki=2Efi/
>>
>> ***
>>
>> However, I don't quite see how to do the tskey management so
>> that BPF and socket timestamping do not interfere with each other=2E
>>
>> The tskey counter here increments only for sendmsg() that have
>> timestamping turned on=2E IIUC this works similarly as for UDP=2E  I
>> understood the documentation so that stream sockets would do similarly,
>> but apparently TCP increments also for non-timestamped packets=2E
>
>TCP increments sequence number for every skb regardless of BPF
>timestamping feature=2E BPF timetamping uses the last byte of the last
>skb to generate the tskey in tcp_tx_timestamp()=2E So it means the tskey
>comes with the sequence number of each to-be-traced skb=2E It works for
>both socket and BPF timestamping features=2E
>
>>
>> If BPF needs tskey while socket timestamping is off, we can't increment
>> sk_tskey, as that interferes with counting by user applications doing
>> socket timestamps=2E
>
>That is the reason why in TCP we chose to implement the tskey of BPF
>timestamping in the socket timestamping area=2E Please take a look at
>tcp_tx_timestamp()=2E As for UDP implementation, it is a leftover that I
>will make work next month=2E

Ok, I guess I forgot tskey is reset to zero when socket timestamping is (r=
e-)enabled=2E Then it's ok to increment the counter when either BPF or sock=
et tstamps are enabled, although BPF will then have to live with tskey disc=
ontinuity when that happens=2E

But from the above, if BT stream socket tskey should work same as TCP (inc=
rement on every byte, also when timestamping is off) that probably should b=
e fixed now while nobody is yet using the feature=2E

And for seqpacket, retain current behaviour of increment by one for each t=
imestamped packet (and reset to 0 when stamping turned on)=2E

>> Should the Bluetooth timestamping actually just increment the counters
>> for any packet, timestamped or not?
>
>It's supposed to be the same tskey shared with socket timestamping so
>that people don't need to separately take care of a new tskey
>management=2EThat is to say, if the socket timestamping and BPF
>timestamping are turned on, sharing the same tskey will be consistent=2E
>
>Thanks,
>Jason
>
>>
>> Pauli Virtanen (3):
>>   bpf: Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB callback
>>   [RFC] bpf: allow non-TCP skbs for bpf_sock_ops_enable_tx_tstamp
>>   [RFC] Bluetooth: enable bpf TX timestamping
>>
>>  include/net/bluetooth/bluetooth=2Eh |  1 +
>>  include/uapi/linux/bpf=2Eh          |  5 +++++
>>  net/bluetooth/hci_conn=2Ec          | 21 +++++++++++++++++++--
>>  net/core/filter=2Ec                 | 12 ++++++++++--
>>  net/core/skbuff=2Ec                 |  3 +++
>>  5 files changed, 38 insertions(+), 4 deletions(-)
>>
>> --
>> 2=2E49=2E0
>>

