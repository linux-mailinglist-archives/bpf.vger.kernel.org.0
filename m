Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963302A6EBE
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgKDUa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 15:30:59 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53465 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731930AbgKDUa7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 15:30:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 40541861;
        Wed,  4 Nov 2020 15:30:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Nov 2020 15:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:subject:from
        :to:cc:date:message-id:in-reply-to; s=fm1; bh=MkLJkdfTsuZq/m6LE9
        YRQzCBoNH8ynmTEDbZNbvS6iI=; b=g2pMChyJTziDlBcbes8G39qPB6Fl0cFSMS
        wkJfD48McDRDD5kqQTMLM2V/+krbbOJlf8x3NdfTCPIh7xOT9PxKlR5pGx5Ku+Th
        zPDe0+0Kdgy9NYMhsWYkuOTNHFpXopAwWZDmSzCkAmMHJpYEh5lkp0L4H05GPHEC
        LijlX1cnXVjUwg/T2DsWwuIB9HuSVTlfYH9fNjvGbF4JKAT5uSa7tMYzdLtCq1CF
        88qdB417M7t4HZwlJCog8eEMKKnq3Qa4SJSwZ/vOhaOs6ijnQXN496CZX1fXBOaN
        UshnWpF93OG6ElWsEfw8DI4Yb6x3W4UNf2UTwpYZKNYprtCP2kcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MkLJkdfTsuZq/m6LE9YRQzCBoNH8ynmTEDbZNbvS6iI=; b=crfFKnTj
        vOWrtkInXILdjiDPoKS1wSVYqh0+hwPzy7L2EVsDkStSdhopmM3dspmYIYriy1KS
        leWsUFouBOwXpdCXwdqn7G6CxJA7E07pLNA8Kg07N8d2AzWZYoTqFpQUCisdBMZA
        tSlNUJ/SMBbStK33Fht1Zu/3LAHU/+OvJE1qm/T7FX7nzLUFqosmuThKh4x6weWK
        DTiwPbv6Lk7lZ844G4ru6vagjaPirHRV+opJT9uIyZzFetgJ4buskdQSCyoHFXK6
        MH5zAWSkSxfZbwNAuRr672++8c/T3UexBM6zxly5UY+qd8vGlUFUu+CLa3WDtpNZ
        jTXEIdjprPdu+A==
X-ME-Sender: <xms:gQ-jX_78RHKyPoMffseekO0TYuJn38IoFL0vzMMcRVUT2hnBkMH0dw>
    <xme:gQ-jX04IymhsW_9Zud7yJJljZhV_g63933OAPOdfsSCX4hOFXvYHmig4yboiltNnY
    fkVz7f_5mPuut1krw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgfuhffvfffkjgesthhqredttddt
    jeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeejfefhudeffefhjedvvefhheduledtueejvedugedvjedv
    jeeljefggedtjeejveenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:gQ-jX2f1w2RpYUpXmJfDIK5-I6Ca_OmhZLiqG5cagCHtyLPJxQzQ4A>
    <xmx:gQ-jXwJzwccQA9RpfW4XUrWF5Whft_i-KbajWsbMoGMG36dx3LnDTQ>
    <xmx:gQ-jXzKIzdiwdfsmlNOXvp25WczknosU3Ji3Rx6a7JdT87KdSmBHVA>
    <xmx:gQ-jX6WpGhTcdQZyurBtZz2sUu-F5EEWPm7pEUrOmZ3g-4ictzL2VA>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AE3132800E0;
        Wed,  4 Nov 2020 15:30:56 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ast@kernel.org>
Cc:     <kernel-team@fb.com>
Date:   Wed, 04 Nov 2020 12:18:49 -0800
Message-Id: <C6UR9QUUYXKW.3PHSMQ3EXUYI3@maharaja>
In-Reply-To: <7831c092-5ab4-033e-8fb3-ad9702332d79@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Wed Nov 4, 2020 at 8:24 AM PST, Daniel Borkmann wrote:
> On 11/4/20 3:29 AM, Daniel Xu wrote:
> > do_strncpy_from_user() may copy some extra bytes after the NUL
> > terminator into the destination buffer. This usually does not matter fo=
r
> > normal string operations. However, when BPF programs key BPF maps with
> > strings, this matters a lot.
> >=20
> > A BPF program may read strings from user memory by calling the
> > bpf_probe_read_user_str() helper which eventually calls
> > do_strncpy_from_user(). The program can then key a map with the
> > resulting string. BPF map keys are fixed-width and string-agnostic,
> > meaning that map keys are treated as a set of bytes.
> >=20
> > The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> > terminator, it can result in seemingly identical strings occupying
> > multiple slots in a BPF map. This behavior is subtle and totally
> > unexpected by the user.
> >=20
> > This commit uses the proper word-at-a-time APIs to avoid overcopying.
> >=20
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>
> It looks like this is a regression from the recent refactoring of the
> mem probing
> util functions?

I think it was like this from the beginning, at 6ae08ae3dea2 ("bpf: Add
probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers").
The old bpf_probe_read_str() used the kernel's byte-by-byte copying
routine. bpf_probe_read_user_str() started using strncpy_from_user()
which has been doing the long-sized strides since ~2012 or earlier.

I tried to build and test the kernel at that commit but it seems my
compiler is too new to build that old code. Bunch of build failures.

I assume the refactor you're referring to is 8d92db5c04d1 ("bpf: rework
the compat kernel probe handling").

> Could we add a Fixes tag and then we'd also need to target the fix
> against bpf tree instead of bpf-next, no?

Sure, will do in v2.

>
> Moreover, a BPF kselftest would help to make sure it doesn't regress in
> future again.

Ditto.

[..]

Thanks,
Daniel
