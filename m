Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268D0250B2C
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXVxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 17:53:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49695C061574
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 14:53:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so11439969ljj.7
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVVUmUEjhUlTVb7b1BdMdHWnhjIy/SevSrF8qGz65ng=;
        b=o+OdpBbEhdzAxMov+FELlKO556B6WXJyb4EkRHX86H7JsZ3KVUpALEgYhb4gmQfLg6
         1Mpsc1guQYqpt3WKQsW24lm8I9WyO8RehH0FIC1Vx5FbLwjIlH2rEjKaBdLrI+Hkz9dV
         yqZNmjinoDwXIjde+/LkhrU4HBFPbIuOvxvdlL4bw937cyZfvHRj6MettSs4YUL6jc9p
         gvyFNXAIDBhXtgWqYuRrXfMGGcw2zsH1Vxd6AzGA9HooLDgSUE2CPi2Bql8PneIdvCoF
         gsnRXmCzEm5Tin5lToopJzDYt27lIn2ZzLbJu0kt9KvGI5o4Txf8+dtta5CoWyliFqKr
         5lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVVUmUEjhUlTVb7b1BdMdHWnhjIy/SevSrF8qGz65ng=;
        b=O6ABbYPlFc8vBSveY5Abl8YpPUzxbw4RvcNqQjmUI4CkgXcNGkOlnk+852lPFv/t+O
         t3ow2yzEr3zl3/K5nrSFxjqOAIEL3+pBCjgmd8a5w6gqOgaT1GOja8szm8lwgpNyHy5d
         dLeUasjYPXr/OwiGbS+OS4/bgqLd9d6paTL4z2Ywa8O1bcJ5+756eVsxueHbPSZ4oIr/
         Zg9J8FEhPqFxk6Se2KqiqkntJGM2baf1HEBhhACO8co7pThV+KNJ/JB+cBCRzc5joNWS
         /xze+2iBuVKU2jGVvpShNgYXYo+S+1I84SVOMcTfxRkAvq0IRzefJ148oVKL0IqaAjtc
         CNeQ==
X-Gm-Message-State: AOAM5303jId8GJZV8qTyfL6QquG1RQPEQkVpmmvLIuU4ehW4qKcnY0q1
        plNEcagiLvl3dOX1qCBvr+BOI61JPiUWOd72utY=
X-Google-Smtp-Source: ABdhPJy3P++YK6I/Fp5DSpI9EStMIsza0SfbrTZ4LJcsIXA+ItSX0rCLdQxfI5XF4GU38oi5lUIIYVLamS1CEPYuNJY=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr3595424lji.121.1598305989792;
 Mon, 24 Aug 2020 14:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200824084523.13104-1-lmb@cloudflare.com> <f984a088-e9d2-7fbe-dccc-d732f924467a@fb.com>
In-Reply-To: <f984a088-e9d2-7fbe-dccc-d732f924467a@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Aug 2020 14:52:58 -0700
Message-ID: <CAADnVQKbO2Lcho1b3DfLLq2j4AgVpvumxhT0e6ceZ13HBMOLqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: fix sockmap update nits
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 8:15 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/24/20 1:45 AM, Lorenz Bauer wrote:
> > Address review by Yonghong, to bring the new tests in line with the
> > usual code style.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
