Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699F0269AFD
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgIOBXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 21:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 21:23:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E7C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 18:23:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v23so1347015ljd.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ai5mKVbRK8ik1lnW5pLkItNwjjZn4vx5VmXVnlf3dXg=;
        b=emJ7CJmppnS8cnXCanb1uNZNzMBvBtGbU8ffDGUuwyDCExI/YY9E98GLAbwIK2YKXD
         VpEJ/0/lnmr+uFP67UGyKqsOhLxJKniA9cohXB9fgLUSlFzoaDRjy+geyZpaKkOn9lOu
         WC/49OvGGg1/xCkckWU87fLp1lTiKIptppfHxyOsvrtCjAnmbWBio0reHE4RfXfjffM3
         bT38ksritGYnx/krMbA8/J4r/2loF1Dv8E4A+ztDLzxTXWCx1HQoy6RpOEQErGDw5T1z
         v/LYRczw73/r0f3HgckWw+DscTgFGuuHH4j2JExA/0M2qsL3cO8ZvuWUp/bq2FEFQ63q
         hHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai5mKVbRK8ik1lnW5pLkItNwjjZn4vx5VmXVnlf3dXg=;
        b=BcoEfOoCuul0O6ODqOwDtJWTEdNHhiE7QBydg4Iqs3nNLNszX1l3g6Ni4jvbHnM0Kc
         qqrb4ViLflYGX6EwNB7zEVhhNKCefOL1XbJPGoJvd51mRcwNBDjlnY7cYi99NQuydjtB
         BGRnTOiW5hwrbqQm8uCOeTEj7uk4XIDsd8jys+yZBhAZNJ951rqUSeBXZr64Bl6Rk5j4
         ffrZdnyxmg8e/CMk2V0MgvrlsGLMp1gQed/MmU1JnLSwgWaAZKqFiUwbObj6MdMSM6rr
         NEe8vIZs0rNOam0k/lmziwurt/yoXOU9rxVKDAU4R6d5lvFyyhv2/mTt/1Ur76QovZST
         g0Mg==
X-Gm-Message-State: AOAM531FUhF4BD0+P8JrAk7HhCbtQG+Nb5KbM9uvB7IrJX9AkD4zNiHt
        ndjNnezjeKJcHrDbqQyzqoetPfZiO67CySY9esM=
X-Google-Smtp-Source: ABdhPJwH4RUjh6b90BRUP4Y3VLa23QWgg0DRGvSPMfUzm9eERmQcr7P24fotfNuBidX1cZza2ettiukEJBEUKO3bvIk=
X-Received: by 2002:a2e:4554:: with SMTP id s81mr6399213lja.121.1600132979261;
 Mon, 14 Sep 2020 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200909232141.3099367-1-iii@linux.ibm.com>
In-Reply-To: <20200909232141.3099367-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Sep 2020 18:22:48 -0700
Message-ID: <CAADnVQKm1+z0WU0OetGOJ1huuMuuQfQ1ryA6Lata2T-p1OL2gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] s390/bpf: Fix multiple tail calls
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 4:22 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> In order to branch around tail calls (due to out-of-bounds index,
> exceeding tail call count or missing tail call target), JIT uses
> label[0] field, which contains the address of the instruction following
> the tail call. When there are multiple tail calls, label[0] value comes
> from handling of a previous tail call, which is incorrect.
>
> Fix by getting rid of label array and resolving the label address
> locally: for all 3 branches that jump to it, emit 0 offsets at the
> beginning, and then backpatch them with the correct value.
>
> Also, do not use the long jump infrastructure: the tail call sequence
> is known to be short, so make all 3 jumps short.
>
> Fixes: 6651ee070b31 ("s390/bpf: implement bpf_tail_call() helper")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied. Thanks
