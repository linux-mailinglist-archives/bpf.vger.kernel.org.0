Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B52D1BBE
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 22:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLGVJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVJp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 16:09:45 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC1C0617B0;
        Mon,  7 Dec 2020 13:08:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id y24so13912139otk.3;
        Mon, 07 Dec 2020 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=P/ijqFbV8KBugVxLlNX1Y58zrs/i9xvHOBeofNv4zLg=;
        b=FS5Jxu9NzE+gitHHvefNFkAi9gWtnK/8Qje+xEm7QmROmRpVjEeUVS3CM1sEuXNAd0
         IATXAWwgIOy/dXpXWZpGsLA26HGjj0+zfCtIRlFabIZiE5P30MroKOXwtxoo9g6w9ahJ
         L13jJXjLAG0/MZl3gNr4Ei1JWo6b5Mp1+8UOmv8UUNO6UAYYUxaX+sjvDzOqsi6jw7Ic
         tfEfWGLEFkF8/Cy6PBx0DKArdGUPmN0I1I2RMIotWNM3jUiedTbwZCadJ3fqNtSMWOEB
         vQgm1lKmawiEpbNISuk13M51Aza93wqfoVapAS5o8xu50PNPVLLWUhBwJ1f+RatcaMBW
         ww1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=P/ijqFbV8KBugVxLlNX1Y58zrs/i9xvHOBeofNv4zLg=;
        b=PRNu2jqvs0Cm+ffxFisJ+LETtW6U3upDlN1DTuU8CtUuHNYaoMJ3ryCUkZCWjlMuf5
         l2pGEjPHOTYaef5VNMpQ/4FmQFunWy6UsyL3upxT9phRJNyAFdNOzQZWD8+nGnUUtLvu
         3hxHDIL4J7ajOAEZmBxsLIvCwFiFUy32oXcdH90cMcWl0NLozaP8OyhcnxmmeH0Eu+OF
         gnqIZcaYFXEDDNLtyaLT55G+RtRyrrg5lWLaFVahmoXk7fNCkaHjIzLquNn59djj7+HT
         sBytafdfn1OSvyTCu03PwBsLXVfQUY8krVQykR5s8u2zQcMLFrJjV+nb40VwWaS+J5ov
         Alag==
X-Gm-Message-State: AOAM533r353EicNUF4rrdPV0w2zwDv1AsMetT8jyhxbAC7Yjvsfhc/4Z
        PDCdpOTARqvtJ57RvPFEToc=
X-Google-Smtp-Source: ABdhPJxgKZuCmZTt0Ax6qvAwbxYPZNAgvXM6GwzY2RF1seo40AjCWpNPtRf7bYuQ8DFiE+VQgAdO0g==
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr15098765ots.286.1607375338793;
        Mon, 07 Dec 2020 13:08:58 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id t25sm2905926otj.13.2020.12.07.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:08:58 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:08:52 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fce99e440d06_5a962088e@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-4-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-4-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 03/11] bpf: x86: Factor out a lookup table for
 some ALU opcodes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> A later commit will need to lookup a subset of these opcodes. To
> avoid duplicating code, pull out a table.
> 
> The shift opcodes won't be needed by that later commit, but they're
> already duplicated, so fold them into the table anyway.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Acked-byy: John Fastabend <john.fastabend@gmail.com>
