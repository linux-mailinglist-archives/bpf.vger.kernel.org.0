Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71503DB088
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 03:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhG3BMJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3BMI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 21:12:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD371C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 18:12:04 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d10so7756749ils.7
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=+G5INvBXtpsTnJ8663d9AJrzVBu2gzBgrQlUeecvQjo=;
        b=SJdfImQ8qACkcx2pChppINXTzPYiUI0vV1JVo4Dl1Ei6yQnE+YrSfAuNldTdcJD95D
         lgWtphNUMQ6+NggMumuqyfcgG4lP+GpgTqkSZKKFKCdY1iJEgf/irTshdVSmDKoQUAFz
         lA2vY6qyo8SRPCnDJ4TZ2z2zimZ/SMS3m+i9JR0U82ugQ3X/aEeswvpek7Z1K2bVzKCM
         O/Zn+CGdWyIKPzvYXtkEKxhqA4O45Q7PEkeLL+U1yssBNlWTrHQJvf8g/W9Klz9rkjnp
         c5lyJKR+h+oqzenfE9Mup4/uN6xzC0aFKrqo7NoiYqD1omxnIstii0SXpZkkVX5bt2pk
         b9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=+G5INvBXtpsTnJ8663d9AJrzVBu2gzBgrQlUeecvQjo=;
        b=Kq/u9ZDF9UqaSSKZplusJzI8XAOC0mrI5qc7O59HUPdoE9ZIsaP8A3wtMZ3K3DFvLf
         JW/mw8n1JsPaYdwt5r34/GChZ72oL33WndVUbJESE8o2zMQyCD/SCCOIZ19iInY1Ots4
         xZc7gheuFuzw+exJfnIL6T5vDbhgUiC3T+z90fT/l3ksW1gOrU0YmmgjaKRcSe5CTudD
         GuYiahUUm9+9APDKMkKTV/I3qcB2OH1/0rp2S2Ze6kPAPUwwUV2y/fvSb9ZffSxY0NQz
         rPqtm1DpS37mCvhuloWI1ncxU73XD9F9GAmbBgZSwlmagZ2sA/7r/KTdc59XGIk7LlUi
         WV7Q==
X-Gm-Message-State: AOAM530CoTqKMyheiiYgjRALz0x+7b5gKTHHh7a3TiJAmwnXg14CPzPB
        l3NN1NgaItQ8QcJqy7cK31UTqfmn4A==
X-Google-Smtp-Source: ABdhPJxllUHPiHLc/pSepNizFafhnfjgRFszTHl80Zh9xY5Nx7HHXcxG1HR/7GZXfUGyUMR61cQpQA==
X-Received: by 2002:a92:ce49:: with SMTP id a9mr5758130ilr.195.1627607524147;
        Thu, 29 Jul 2021 18:12:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m184sm24690ioa.17.2021.07.29.18.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 18:12:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B359F27C0054;
        Thu, 29 Jul 2021 21:12:02 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute3.internal (MEProxy); Thu, 29 Jul 2021 21:12:02 -0400
X-ME-Sender: <xms:4lEDYQSULskRsLTNQrpDd44lxrR_qWqOSXwOJ9gZixwdn-9VDe6fMQ>
    <xme:4lEDYdy5drWuq6O2ceW38it4jTjn6N8I_TvXKX4ytoa5ofLzBk94zVXcS3mCdbQhJ
    azMoes7MUU6ct7Zq5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheeggddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftfgrfhgr
    vghlucffrghvihguucfvihhnohgtohdfuceorhgrfhgrvghlughtihhnohgtohesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepledtteelfeekjeelvdelieejfefhkeeu
    ffeitedutdelueefkefhvedtffeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduvdehieehledtgedqvdehheekjeelfeeiqdhrrg
    hfrggvlhguthhinhhotghopeepghhmrghilhdrtghomhesuddvfehmrghilhdrohhrgh
X-ME-Proxy: <xmx:4lEDYd0iuQSp_Buu3LhyCGS7NnAimNxPL_NnFm843yN6oYOgSegwrw>
    <xmx:4lEDYUDSxWYIURZU6bAfAg-d-aKPeFYnPLzdqSF5oye9KtY42KkPfw>
    <xmx:4lEDYZjJYwwThr0ZXuuJis7Aqe9lVoM90t2F6syU1t3YtcaiTUw7Ag>
    <xmx:4lEDYTfMTRLXGtu_ePUhMTRMCskhNoNsXAW6tp7PbGHUeY_QehrZ6w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E21714E0315; Thu, 29 Jul 2021 21:12:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-545-g7a4eea542e-fm-20210727.001-g7a4eea54
Mime-Version: 1.0
Message-Id: <590eb5d6-c9e0-4cdf-919f-47b24b2c384a@www.fastmail.com>
In-Reply-To: <20210726161211.925206-12-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-12-andrii@kernel.org>
Date:   Thu, 29 Jul 2021 22:11:41 -0300
From:   "Rafael David Tinoco" <rafaeldtinoco@gmail.com>
To:     "Andrii Nakryiko" <andrii@kernel.org>
Cc:     bpf@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_bpf-next_11/14]_libbpf:_add_user=5Fctx_to_perf=5F?=
 =?UTF-8?Q?event,_kprobe,_uprobe,_and_tp_attach_APIs?=
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021, at 13:12, Andrii Nakryiko wrote:
> Wire through user_ctx for all attach APIs that use perf_event_open under the
> hood:
>   - for kprobes, extend existing bpf_kprobe_opts with user_ctx field;
>   - for perf_event, uprobe, and tracepoint APIs, add their _opts variants and
>     pass user_ctx through opts.
> 
> For kernel that don't support BPF_LINK_CREATE for perf_events, and thus
> user_ctx is not supported either, return error and log warning for user.
> 
> Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I think this one is fuzzy in v2. Checking them now for my purposes. Thanks for CC'ing.
