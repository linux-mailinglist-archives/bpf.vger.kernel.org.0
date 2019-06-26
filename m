Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213A356AFF
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFZNpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 09:45:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36134 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZNpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 09:45:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so2563445oti.3
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHFWUQ+R+XxnRQJJOUqJpjk7wSBUzKlBOHoUk7O0irU=;
        b=cdmp2X1xhHglbhsZdcJ8yRfsAjXdswiMTIWmfU6q1VXqPPUgNT+TivwYZpI5F6RcNf
         MKmD2nBOoE67fhqJvhwHqXWKr+Rg5KchGM2GxuE3sgOxQGDBnMHQmme/3ooayAoGHiCm
         9tHtywRruw9DMhBK1Tt8vK2fQdhGQEsb23HQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHFWUQ+R+XxnRQJJOUqJpjk7wSBUzKlBOHoUk7O0irU=;
        b=IC6ppsg04rELfPk53HDkMtgnzahsScj4QjKtjaTuh1VWzJ9RRnEGO98Cg1ELUsEopo
         mNl+RgqJ0G+PYvGQzbHc7BU6w/YC/pE9WE7Qlr2agVw36ZsmuJwl0pOYYDWzi1vrzmcM
         rjk6hWkooBhv5CaExzEhhqHYs2TlQ+9JropxvbFJHvpDga4DicgmKazKDMP3XkmMyJ/3
         bWBxOwg/ayMqKnjXxaNJEx+RrTDRFXq9LEhhZjwHMKXnUsSNWoF/YI7y/0Uh+I7wqJ9r
         xyVlR9nRILXQWg71QaKSXyY7L5DnyI/WVAQ4EpPPxjeH1PcMg4RJ/IhgjWAuQ+MyFnVO
         Lh/Q==
X-Gm-Message-State: APjAAAUm6xFG7SLG9QXmeGvKhPMDx0j4twKF8L6pd8h5H+GzN1cjTcyb
        hD5mzkRYYY9PNqfe8HXCS71aiR0uiIc/5vBY4uBVpQ==
X-Google-Smtp-Source: APXvYqxiSvvfwHYrgXdyFyvunZdWv8OQCOZLiIhDoRnyCI5hqlYDmUcxSdljyNgiErgEAm6/gkd82XxPQgTpQp/m56Q=
X-Received: by 2002:a9d:1b21:: with SMTP id l30mr3404935otl.5.1561556723877;
 Wed, 26 Jun 2019 06:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190625182303.874270-1-songliubraving@fb.com> <20190625182303.874270-2-songliubraving@fb.com>
In-Reply-To: <20190625182303.874270-2-songliubraving@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Jun 2019 14:45:12 +0100
Message-ID: <CACAyw99isFcFhnrmagmzPPR1vNGqcmDU+Pq7SWeeZV8RSpeBug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 25 Jun 2019 at 19:23, Song Liu <songliubraving@fb.com> wrote:
>
> This patch introduce unprivileged BPF access. The access control is
> achieved via device /dev/bpf. Users with access to /dev/bpf are able
> to access BPF syscall.
>
> Two ioctl command are added to /dev/bpf:
>
> The first two commands get/put permission to access sys_bpf. This
> permission is noted by setting bit TASK_BPF_FLAG_PERMITTED of
> current->bpf_flags. This permission cannot be inherited via fork().

I know nothing about the scheduler, so pardon my ignorance. Does
TASK_BPF_FLAG_PERMITTED apply per user-space process, or per thread?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
