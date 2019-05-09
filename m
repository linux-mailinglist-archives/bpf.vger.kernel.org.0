Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE16195C6
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 01:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIXte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 May 2019 19:49:34 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:41302 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfEIXte (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 19:49:34 -0400
Received: by mail-vk1-f172.google.com with SMTP id l73so1037886vkl.8
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmYX659fV6r4Gm0v8hnRgrQfidbFwDmPBM+p7Xf5l2c=;
        b=lMVdST3HK0BasoOapTbMFuODdMNF5OMusynTrL/1JjWVfCp9W0iQJNamdi0t6BW8dU
         UZ4bCmX6mKZ1Is6qZ98yw9MBCEocvhPI84WVsisg5AFXc/6our9q02QKNc+x6eJL9TYh
         +zzcTdT/R1DcjB1QEDkbiq8arOA1TmSGlC5c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmYX659fV6r4Gm0v8hnRgrQfidbFwDmPBM+p7Xf5l2c=;
        b=QIoq5xOAcSh+/J9DZ24Nh6wX9wJ4hVUYYDBoDSCcaV+DJ9mPM6f8N/DQs4HnCasiMM
         gykf7zitVkYsSasoHjHxsicvgeWqwE2ChmeZg8wKnZFW/LoCdF7RiazIjjkLBsgvcjGy
         tRspQaFNn5+37fQaofkia9yXejjK3WjWLnfufVpUykioVXj8EWbt1v2Hv1t6slLmf5Nf
         hEnc+8KCVWltrwZtYUPbtB9KHM86W3gr0GQ71COP16Qh8u/42+0c73/NKkbkrhRexjo+
         OxeXLCHEJqygm5jrauAjv5Kwpoi1ZrTQHZJ+YIzZF+610+zFF5HMPLOvaM74aJHPPGUL
         04rg==
X-Gm-Message-State: APjAAAVNXU9CdtRlD0BkBFjgVCQfperpjChOsbFPyvLz6J7BY6CMtb7c
        UasvnIX4lWYDc83ACopTo+uX8YD57tk=
X-Google-Smtp-Source: APXvYqwwBIcouSmoYoVI8miAAPRMqwH5GI8EfoYLSIvNDpYt5OlLUuYK4vAE1v1AmS8c4dvIU8VgLA==
X-Received: by 2002:a1f:9f89:: with SMTP id i131mr3525652vke.19.1557445772913;
        Thu, 09 May 2019 16:49:32 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id d9sm612405uab.20.2019.05.09.16.49.31
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 16:49:31 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id v7so1479439ual.6
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 16:49:31 -0700 (PDT)
X-Received: by 2002:ab0:1646:: with SMTP id l6mr3707720uae.75.1557445771225;
 Thu, 09 May 2019 16:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL_XLb5C-+DY5PRhneZDJv585xfbLtiEVc3-ejzNNXaVg@mail.gmail.com>
 <20190508230941.6rqccgijqzkxmz4t@ast-mbp> <CANn89iL_1n8Lb5yCEk3ZrBsUtPPWPZ=0BiELUo+jyBWfLfaAzg@mail.gmail.com>
 <20190509044720.fxlcldi74atev5id@ast-mbp> <CANn89i+v52ktezz5J_0of_EvTUozf86rP1Uh36HpbHf33uzDJg@mail.gmail.com>
 <CANn89iK8e8ROW8CrtTDq9-_bFeg2MdeqAdjf10i6HiwKuaZi=g@mail.gmail.com>
 <e525ec9d-df46-4280-b1c8-486a809f61e6@iogearbox.net> <20190509233023.jrezshp2aglvoieo@ast-mbp>
In-Reply-To: <20190509233023.jrezshp2aglvoieo@ast-mbp>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 9 May 2019 16:49:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLVCSGyB7G2-PUBvGDYK5=HtNAUwyUyJCpgnmAvarpuMQ@mail.gmail.com>
Message-ID: <CAGXu5jLVCSGyB7G2-PUBvGDYK5=HtNAUwyUyJCpgnmAvarpuMQ@mail.gmail.com>
Subject: Re: Question about seccomp / bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 9, 2019 at 4:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I'm not sure how that can work. seccomp's prctl accepts a list of insns.
> There is no handle.
> kernel can keep a hashtable of all progs ever loaded and do a search
> in it before loading another one, but that's an ugly hack.
> Another alternative is to attach seccomp prog to parent task
> instead of N childrens.

seccomp's filter is already shared by all the children of whatever
process got the filter attached.

-- 
Kees Cook
