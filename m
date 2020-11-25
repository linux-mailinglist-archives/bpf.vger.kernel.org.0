Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCB2C3F84
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKYMFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 07:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYMFJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 07:05:09 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DEC0613D6
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 04:05:01 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so2036277ljk.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5FUjWxpOQ9zrCued6q8VeN9WGm6VgBFm9lfLrKQbsk=;
        b=R0rjGOpoCeLCagqI1sJ83TnqIgosI5MW9SQKWqklodjOkP6evlnIvgzzl4Or4JHdIC
         ibygpDOJBwvnUP0hCqyfLx/pBm0AKminSD0QrcXq7U0wHG9ghmO21aNF/pizF0LkDBbc
         biBzU/fnTR4ezxv16GJRfgs/RjTrW+M8lahOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5FUjWxpOQ9zrCued6q8VeN9WGm6VgBFm9lfLrKQbsk=;
        b=B4X5MaSdJ/80JEWIPCEGUrp4lHbHGKP87Dqz75vdTbpjgTGHj/NY7GeH9ELc999O0O
         VNIrx1TZwyJCPIhTM65MOqo17I08isCaPPB3IhG2pjiwvr+fv4wlw0EMVrq+JBki+WJk
         CZ4VFQu9y4fgFsgDP4MHCeEmUQdljxgPg1XNNONl4ZQAGKPmVyjw5XhU5MCaeDMtYK/c
         1GiWvblxmnzn8SNWrTqfNnH7Wbm0PIHvKh1NsNHRwBEtRMUnBOKbFQhrKplHPPxXOA/o
         JbESYdgKe//nKpfFd0r8BWOsnTu72PpPU2bXQ6pmiriTtwi787JJo7XYlCs0c+SEEVOQ
         AeRg==
X-Gm-Message-State: AOAM533aXssLG7KRUnkhJMnuVbSh2NeceusOIcfd15q4VvzNlYEX/6np
        NPVA/ww6fZozknlIoNiHXFpEAzW5iL5fERs2fWp6ah9N8duaACLh
X-Google-Smtp-Source: ABdhPJzxIAysOZN/U4xhG7czC43qYmFbb4hpHmlQUzaVX4IBNdWDCl1YNNVf4IVxAMSNt3qPOQvxZ6gTKifImFD4b/U=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr1280770ljo.82.1606305899970;
 Wed, 25 Nov 2020 04:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-2-kpsingh@chromium.org> <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
In-Reply-To: <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 25 Nov 2020 13:04:48 +0100
Message-ID: <CACYkzJ51imU+_iNR3zG2pzqvVoewSE+NCTJo_V5ZGYJOej-B-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 6:35 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/24/20 7:12 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > This is in preparation to add a helper for BPF LSM programs to use
> > IMA hashes when attached to LSM hooks. There are LSM hooks like
> > inode_unlink which do not have a struct file * argument and cannot
> > use the existing ima_file_hash API.
> >
> > An inode based API is, therefore, useful in LSM based detections like an
> > executable trying to delete itself which rely on the inode_unlink LSM
> > hook.
> >
> > Moreover, the ima_file_hash function does nothing with the struct file
> > pointer apart from calling file_inode on it and converting it to an
> > inode.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> There is no change for this patch compared to previous version,
> so you can carry my Ack.
>
> Acked-by: Yonghong Song <yhs@fb.com>

I am guessing:

*  We need an Ack from Mimi/James.
* As regards to which tree, I guess bpf-next would be better since the
BPF helper and the selftest depends on it
