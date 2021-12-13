Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B64473844
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbhLMXKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244065AbhLMXKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:10:22 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76126C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 15:10:22 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id n9so12957979uaq.10
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YNyWD6nMoHDM4TrQcSVbpxnCur8MHe+YM7n04AnMZKY=;
        b=XGIvO1eTPnD3gPRnvsvS2iMfFbMhdzotfcwe6zcwWlBZBX75Hq7zYrckxUUx0o2AY4
         q3u2HQA9k61/1e/OHiS+RpLQ0Z1Vh+QnHppBpuWX3z5U66BQxeEmPYO+AfaIZCRhnyJf
         WgbYgDC1Q4c8fWvZrZ7P9pOBQ7rUspd0xwsX9Y9hIYCnPQF/FX/wDu5zcxtgFeTdQsJ9
         U6l7phil98l8qUdaiwwOYmW9rjA9/s9/jWvnwDqhgEdOFVRY0oGi3cgVut/peo1fzBr+
         WteGxdfqcflXAG0T8uSurCO2fbDKZy5DBB+Mia03k4qHx1+hHvVoPZMc20Oibx1ab863
         H7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YNyWD6nMoHDM4TrQcSVbpxnCur8MHe+YM7n04AnMZKY=;
        b=zQubK3I5gdPgyNJ2nruL+nbTneh6rRHx4aOuLxsgVzy7kZK1QR9fGXRJrVGUhZEk2a
         jYnh3dYuX/v27ivf1wmyjAYruw2M4FVvmqs5SKHQmREAgPstChg8rs+9Ojqpfnmzpz0w
         4ku4lOB8yMpjYP/7zuh9HETYAs7LW2AI944QMNQqlGRHGmgGoun/WUFT9HdLRpGi1HKN
         NGHAh2Ew+LE/ZrcpCxFEnlOumrduwvccJPQkLxqAxDXSJNQNoReYYUk2Uuv8y31+YzQK
         jB1GID4LjxUkSg8mAnLrjBIY1pennwxqesRdyU1jvgrln+YnoizvnNe6LJpTC27zbbqn
         rUNQ==
X-Gm-Message-State: AOAM532LF7MteK9mQ34s0prbUgvVRRl+OgRZXNbzti5NF5KGRpOi64Ye
        xkgDZLRYisUnQxpenIm8IEbYZ2PZF3nLyfD9Tk8bTcvt8gRalA==
X-Google-Smtp-Source: ABdhPJwnw3dLFmOBPGz0SK8imi7yM/Xl8LnRiszmB7F8TO/IXTBl/OxclolWvDbztCCOGTdbDH3ukh9TpzhdCXEFLT4=
X-Received: by 2002:ab0:6ecf:: with SMTP id c15mr484705uav.6.1639437021323;
 Mon, 13 Dec 2021 15:10:21 -0800 (PST)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 13 Dec 2021 18:10:10 -0500
Message-ID: <CAO658oUqd5=B3zkDhm2jVQxG+vEf=2CE7WimXHqgcH+m0P=k_Q@mail.gmail.com>
Subject: Question: `libbpf_err` vs `libbpf_err_errno`
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm using libbpf and want to make sure I'm properly handling errors.

I see that some functions (such as `bpf_map_batch_common`) return
error codes using `libbpf_err_errno()`. My understanding is that since
libbpf_err_errno() returns -errno, these function calls can just be
followed by checking the returned error code.

Some functions (such as `bpf_map__pin`) return `libbpf_err(int ret)`
which sets errno and returns the error code. In this case, does errno
even need to be checked?

Why the inconsistency? I'd like to document this, so anything else
that you can add on error handling in libbpf is welcome. That includes
example usage.

Thanks!
