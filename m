Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947CC1CE340
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgEKSxJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731213AbgEKSxI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 14:53:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E0C061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:53:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d21so3047768ljg.9
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0TYRND/ABi7PIIhOtO24f2VytaVAkSVXBd42PIJIrHs=;
        b=IeZdFkntoHFzlO38HPewKXBqFfn7uWOAgVHONj3EuvbJUvJcQr6XUpGjtKN8+bL+wi
         JrBpnin6lCdwcNAhGWZtYPQiLsBeJcQJsqB3Tsh/rCErMybwRf1rTM4vFpG24kp0Atsh
         7ywX8v+vXD1USZ8b4XPDoIej5YVwGCf53RapegfHIONymBE7ldGbPAeaGIobr6VJhBjQ
         Ls3d+t8GJc4xhh47501B7MZB2THCZzkMBSb1bwKCoDV/orSTjpemU2sDeNA0eaV8O59t
         vA7sSHw6HmqZrnTI8clZbnpgKN9lLw6OqfAvNHM82qJRQOds0Ru0INCofZCwlfz87Tbv
         UbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TYRND/ABi7PIIhOtO24f2VytaVAkSVXBd42PIJIrHs=;
        b=EL7oxNfQjMZErb11NfKYDWZC7N2NiBJHD18RKKLCxfhvfk1ZwAiZp1wzJ3j4UdJTM0
         ZwVfGTseRZISvP4RPX9b2ZGGC4NnliPDMza8CO+wfRIr+Lo+3GC52cyQZMDsavdLNutv
         429jL7cSIw26SS6gvLqFw+M6ewBydhPTWP1GHbOrpUngatxj5X9/w9de0hkW7U12rh8+
         JAR1Lew60ochOydX9zsJHlZo58jtDUevHBk8u6o1/g4Pwt6yMnaq9iYcQz2xlE9kwgS1
         WvopiSWnueyrBcaa3Syry8Vqc7plvyxzh10sTWO3FlNnlJe/3AXq5S/qi611iKtrRZGW
         G0Qw==
X-Gm-Message-State: AOAM532BTJX7es+DUWYqfZUSjcz69alCOf7yZKB8fpBUwKKBPJ2ZEUqf
        8jyulShs7sln0oDLJrGfQzjnd/0tbxQttERUXhw=
X-Google-Smtp-Source: ABdhPJxPAsxYALV9JzkEJWc85qBOQSSQdpFS89HCHLqK4RU9f41vp6Rx9S3n70rsTZdcQt+OoTzfRNfUu9/I+BnlnD0=
X-Received: by 2002:a2e:9611:: with SMTP id v17mr10398250ljh.212.1589223186674;
 Mon, 11 May 2020 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <330319358.22380533.1589199587680.JavaMail.zimbra@redhat.com> <1556585430.22389743.1589200726419.JavaMail.zimbra@redhat.com>
In-Reply-To: <1556585430.22389743.1589200726419.JavaMail.zimbra@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 11 May 2020 11:52:54 -0700
Message-ID: <CAADnVQLjWez5CcEWnyfhkSn_4qnRWwDeYNEOnfxYG3DiXGE2vg@mail.gmail.com>
Subject: Re: Mailing list for CI results
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 11, 2020 at 5:38 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
>
>
> Hello,
>
> we've been discussing CI for bpf-next in previous meetings. One of the
> action items from there was a creation of a separate mailing list
> purely for CI results, to not pollute the regular development list.
>
> Is there already a list created? If not, can it be done? We'd be
> interested in sending out some examples to get early feedback before
> the testing is enabled.

I think any mailing list is fine. It doesn't have to be @vger and archived.
linux foundation can setup one.
Or create one via google groups.
or any other mailing list service.

> Please let me know if I should reach out to someone else for this.
> I'll attend this weeks office hours to discuss other CI action items.

Great
