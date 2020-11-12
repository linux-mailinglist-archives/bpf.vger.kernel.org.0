Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664FB2B123C
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKLWyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:54:18 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40959 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgKLWyS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 17:54:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 38F103BA;
        Thu, 12 Nov 2020 17:54:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 12 Nov 2020 17:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:to
        :subject:from:date:message-id; s=fm2; bh=hR/B1/mksMg4nf29wakGk+i
        VZrvBuyXfFOqVP/Ac498=; b=PpFzMzXHxp5c6435BPLh0Op1Z51473xLnoz/1D4
        PBzKXLL1Trl/iGVvSS5hQQhbohhoNbjP8WrhMQDwSkOb6IkWc5nSrSC+w2olGuG0
        p684008oVCResM6N2owZJ6AQaEfREjD0HTKhe0ADsHz47hfc4mCBHdcgQsqa9JxL
        jags1GBklYdLwgDCn1ikmc7/NaWejeKDQB5ZkieowKoTgBDb1r89CRzAdeIRug2f
        wFy46wHhTJitMf5xo5mLJqU1s+qcbo5avNVjcG6kQ9JhB/xqt5xOYw9NNWviPsXd
        d6gNNYlVTqFb/uhD3mQawNCA3QNwMfALnPo1saeGR8UBqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hR/B1/
        mksMg4nf29wakGk+iVZrvBuyXfFOqVP/Ac498=; b=ee0TLRkp2fG616K+S4BtkY
        QE2gR2tMJSRWl+4CaUwucfcT+GnwlwzpNF7wlSLq6aKVvzHNuLA5BMw9xXfWiSSP
        UgZdGSqJloZs0mNuEBBB4bbCTzlOD6NvB0xguyi/ElSs1bK47O2xFezLPBxbdLO/
        otbXwIdMv8rwVZ7vqxlJdMPQAiC4Qg1SflhlW/6ppfXJm1gOu/82pv93FqX0v1Hx
        jza7fwyTffAlejbtqDMmXTt2tdlTK/g+bX0IYzdv1alqNQLJUpNtu0QwM3QF/NsN
        HKuyA1usrr6nx1dAGiMGF6/KbtKAl0Yx0gIzFIzJY9qG9tsuN/0njyL8mZpAr5aA
        ==
X-ME-Sender: <xms:GL2tX90c3a_7ME0QM9eV6Ai4uYVITNRql1e05Te9901r8TV2JkiGvg>
    <xme:GL2tX0H0xRI1ereI4-MApVha0hemKRvkvhpemUkt9OlPopMEQh3rWFL0zUIN91OmX
    XPKTSKkPioQEl5mQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpegggf
    gtvffuhfffkfesthhqredttddtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeiffehfeekgfeitdehff
    euhfekgeelfeduueejveegueejtefhteetuefhgefhteenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:GL2tX969B1mYIn12uTA-THcyXSuOPXFfQKeWB8ALsW_RJyAZtbnz_w>
    <xmx:GL2tX623bK4F6iUKKtagNsJw5ic5aZPXrSJoINjF8-QuFCT9F2_IPQ>
    <xmx:GL2tXwFnD4d7qoSmua42oGF7h01WyxBCLKMMSoIhtEEibbJCSq9JZg>
    <xmx:GL2tX1Tz5Th8EgmiqeUzw5EDxLDKHkafgk3ZT3AtJWqMZ_9G9wNEVw>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBBF5328005E;
        Thu, 12 Nov 2020 17:54:15 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <yhs@fb.com>, <cneirabustos@gmail.com>, <ebiederm@xmission.com>,
        <blez@fb.com>
To:     <bpf@vger.kernel.org>
Subject: Extending bpf_get_ns_current_pid_tgid()
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Date:   Thu, 12 Nov 2020 14:20:35 -0800
Message-Id: <C71MVCBQMCPF.1CCKLFRTGYD0D@maharaja>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm looking at the current implementation of
bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly
restricting to me. Specifically the following line:

    if (!ns_match(&pidns->ns, (dev_t)dev, ino))
            goto clear;

Why bail if the inode # does not match? IIUC from the old discussions,
it was b/c in the future pidns files might belong to different devices.
It's not clear to me (possibly b/c I'm missing something) why the inode
has to match as well.

Would it be possible to instead have the helper return the pid/tgid of
the current task as viewed _from_ the `dev`/`ino` pidns? If the current
task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The use
case is for bpftrace symbolize stacks when run inside a container. For
example:

    (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'

This currently does not work b/c bpftrace will generate a prog that gets
the root pidns pid, pack it with the stackid, and pass it up to
userspace. But b/c bpftrace is running inside the container, the root
pidns pid is invalid and symbolization fails.

What would be nice is if bpftrace could generate a prog that gets the
current pid as viewed from bpftrace's pidns. Then symbolization would
work.

Thanks,
Daniel
