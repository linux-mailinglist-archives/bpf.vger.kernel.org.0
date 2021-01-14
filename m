Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36822F5C36
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhANIKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 03:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbhANIKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 03:10:16 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B244C061575;
        Thu, 14 Jan 2021 00:09:36 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id j21so1172236oou.11;
        Thu, 14 Jan 2021 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aflm5DlmshNk5nchTDEsVtg98kBiImMjb4vEn+XiP+I=;
        b=J2uRbV9ScW/yeAQB/5037uG8RTqrLuzjhALs9mpRTRPXf+WelAq+TiZlgPMP7Ecm/H
         mwNsbEUnFd3so7hzqY55Zu8FFg9OxMxshIey2sBN+v+51Z6rDkNwOeZFpENKY/QgMCUo
         +A22NNO0EbplDtsX26HIN6nPtkpZui3kDr/HRDMTn63AJusqQ6uP7BtSK44ThAcmZArh
         NGVlfH6h4566PdYgjAZ5bjqRL3hv9weKQ6hjkQzoikuwruxCeGowNRrjIonzk6bjC3w1
         +uTlktjamovNXivAs8CPOoqiS9+/3hBqsE/lla5N1GgRGAXWkof20bjZEeHRGoS8pwTl
         XEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aflm5DlmshNk5nchTDEsVtg98kBiImMjb4vEn+XiP+I=;
        b=lyeWY2WdNKqOFgyWgK0kzo/SDUNqykzbJdAYVQBPK1Z08BPJVBF5rovX0mJoZdDxda
         7jkt3fK2BcoNxSEgNHt16sM7Wpr0uPSAZmeoQQNjku3lD+bbTPyMmkUfNCPCXPBwkWsd
         BtE7drIJBoA4PV7dZhquoBLrMQjgtg5UO0I0U/hrDWPPuVzuGwi53l+uixA2IDTOnHyQ
         onjsBkFWfrrfuXKNVZK1FEpEZ3W30sQj/TfAS4RcCkySdRJHxZkrK2Rv5VqGzT5Wk9xD
         r9Fy2t/v2S2cuGnw20hs+I5K7nWQDHnieyNWDJct4VO7khT9UJJAaT+jaIGvcoJ5XCvZ
         YxKQ==
X-Gm-Message-State: AOAM531Pne1WFn+IqrYSxrKFtAFYhIezdHr3ln86ZZAfDoocOA27HvmB
        GcY7QpCZEa/Ge7JvL1PUI+w=
X-Google-Smtp-Source: ABdhPJwoNeknftbdzuSmdphSD4dYiRbgD//HFMkTGqVzX7WNsIGGH/z930cevVDohwHufitHqIe/rA==
X-Received: by 2002:a4a:e89e:: with SMTP id g30mr3924003ooe.17.1610611775597;
        Thu, 14 Jan 2021 00:09:35 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id t25sm945601oic.15.2021.01.14.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:09:34 -0800 (PST)
Date:   Thu, 14 Jan 2021 00:09:26 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5ffffc36c3ffa_1eeef2081e@john-XPS-13-9370.notmuch>
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
References: <20210112154235.2192781-1-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v6 00/11] Atomics for eBPF
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> Happy new year everyone, and thanks once again for the reviews.
> 
> There's still one unresolved review comment from John[3] but I don't
> think it needs to block the patchset as it stands, it can be a
> separate patch. Hope that's OK.

Its ok on my side if it comes as a follow up. I think it limits the
use cases without it, but no reason to hold up the series IMO.
