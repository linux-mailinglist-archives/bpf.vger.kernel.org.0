Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444ED24C72E
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHTV0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgHTV0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 17:26:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E6C061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:26:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so1664773lfi.13
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=266Yumt0TOx3MCeA/13iXavjTPv34++Xa5BhsGOIa3Y=;
        b=beYcRb61bzPghCT+lci6SSB1liMUeXMv3rhqolwp5d/VVjVlmBu0+EQY2NR6DWDHA/
         nU1dnOo0ELdbhoKFdQ+51rgDjuMwjwj0TqRY2ucg0DUxMPyubb9EwYcwIB1XBpbLSTVw
         Mrkqi4WfLghpqx1iYyaW4rSxn9/pPok7sOw6wh6A9w58yC8jKMtCLo2BwdE/eBEPMCyC
         WnvlMQAQ1ZaKx6GCYOnCOwQwwLbErVUQsWLn9OYpf8BEgLEPTo/3FJtKjsF+IfP91Exc
         hCD6GxIYJH+M6GD6+sI9E9ThicbBPCBCFSVpOj9NTdXFZwFztG79Hhxf5biIirgM0/Xk
         hMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=266Yumt0TOx3MCeA/13iXavjTPv34++Xa5BhsGOIa3Y=;
        b=bLWBWu0Pp1BUBQ5SbOoLYwze88V+Wjauf0rwGxrjDQyBVVDz8TofMdW9Ybyoh4Ewdc
         dlsYCPHWyTBGqm/4LhlpZOsLd14iwb0k/ljoKaKXa011D5qSXygs4HkMz2+7QPOvLkjD
         6h0zTLYACTSD23VdVkf6Ba2WqH1sESKnbTHaBhvkCATwTQUncdi/SppmYZ0vPO/zKtaA
         5LZcQ5dtaZDffOOjUGN/S0lqwDIQviSMKd/blDRj5oVmXRXSp+IMTd5DYEOOTLLV0ggH
         L+tLX2YaA9P0y5W2yA/zym7poDmtvy7OkWZAC0/Aghc4WdiE1+/JDI40bxMnlmCovSos
         rAxA==
X-Gm-Message-State: AOAM530IsafMN6Ff5u6xZhclLmRHuE1pmqYTa95srcRQfaqA38lmvVdu
        c+vZfWDAxj+9IYIXKnzvYob3N/9T1cursXYEuFw=
X-Google-Smtp-Source: ABdhPJwPOEkt8HE1Qo3DuqDuQjS8dAAwj3Z1y3UhjRci/xryF5RY0Ztaqbhn+4PoQktfOC6Y/IzrWJVdMw7CjX5hgec=
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr150097lfb.196.1597958806572;
 Thu, 20 Aug 2020 14:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200819160710.1345956-1-vkabatov@redhat.com> <20200819181706.2220bc71@carbon>
In-Reply-To: <20200819181706.2220bc71@carbon>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Aug 2020 14:26:34 -0700
Message-ID: <CAADnVQL1orZpaNyxRt6nL-1K=LTc2+6OT-F0LhyuyLSgpCMT=A@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Remove test_align leftovers
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>, bpf <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 9:17 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 19 Aug 2020 18:07:10 +0200
> Veronika Kabatova <vkabatov@redhat.com> wrote:
>
> > Calling generic selftests "make install" fails as rsync expects all
> > files from TEST_GEN_PROGS to be present. The binary is not generated
> > anymore (commit 3b09d27cc93d) so we can safely remove it from there
> > and also from gitignore.
> >
> > Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
> > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > ---
> >  tools/testing/selftests/bpf/.gitignore | 1 -
> >  tools/testing/selftests/bpf/Makefile   | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Applied to bpf tree. Thanks
