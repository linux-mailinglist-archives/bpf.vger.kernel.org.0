Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A42D1BAE
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 22:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLGVIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 16:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgLGVIG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 16:08:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D2C061749;
        Mon,  7 Dec 2020 13:07:26 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id y74so16990511oia.11;
        Mon, 07 Dec 2020 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NmTBIYR5a7GHek/f1Tc4SvMiMP/uXzmkTt8oc4bEM8g=;
        b=AfJ8l2FRPARTTdoMFkfnoCHnLIt4cPht3SzEqokTiewfEZXMfO2lZ83KI2sY/4u+WF
         re+qMYqwJAwshAEomPRi0L3ZE6sgfL565WS4P2k1l7EYkbvylo3OG3su1amI9QoUVmtI
         uiMpUiq1vBkoQ8y2riJMTz6vbu/RA2PWdYSrll7w52UFyQICTvGuqqo23kiWMnnhnD4n
         LM1NLXGngpJ8vMmRSUB7IyhBeI4CXPwoBGVa82hpdSOAWy72g8bwwB4elx4q6HaMx9Fi
         uGV1tL2TRcXZCTQYfuHpYVhYA2T/mBzbEbjEotFE4v/CN1bl3/rGy4w6NnvLrM9UdYdV
         uaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NmTBIYR5a7GHek/f1Tc4SvMiMP/uXzmkTt8oc4bEM8g=;
        b=BkeH0elXU/NRSdDVSoheHIUimTIEopquHeL0UUGaPi5uZdq6J9kps+a0SfK0LzuXWJ
         3ywieS7jls/bIt6P0TUaSDGlLOoU74LYjDjDXMvyaV1JClj/3gxb8B2BuRVMkoPG/vjS
         VX7mhtcsHgBRYc0UrVURsJp13opfEb27okomjdRuap6StXRkvIy6dYy3SlXs6IADrPQv
         IU8LJFd/KVHrLOi7o0o2PJ5FdibHoQ8XEln811Z5d+hcx9g7/ZNDbnw7QteG6SaTjfam
         35OMNh71wQ56t3N7odySEtm8BJb8cM4HmpOFxwjzkdXKcA9+iXurKY7aaBKR0uukR0SH
         +APg==
X-Gm-Message-State: AOAM530TW0n4oqSqNZp+jHnIKSGFCJVOieM3ELxFDfDiOu7wy/xa1ZGS
        ZBi6m5CYEM6j3I47Z9xJf1w=
X-Google-Smtp-Source: ABdhPJwH3tdhoPuogsyMez5WWFd6fp5uz/jljp++auWygVt6V6QcIEZAn9H/VypCHot7x1xqOortyw==
X-Received: by 2002:aca:5e57:: with SMTP id s84mr542079oib.102.1607375246093;
        Mon, 07 Dec 2020 13:07:26 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id z14sm546150oot.5.2020.12.07.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:07:25 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:07:19 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fce99871ec8c_5a96208eb@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-3-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-3-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 02/11] bpf: x86: Factor out emission of REX
 byte
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> The JIT case for encoding atomic ops is about to get more
> complicated. In order to make the review & resulting code easier,
> let's factor out some shared helpers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
