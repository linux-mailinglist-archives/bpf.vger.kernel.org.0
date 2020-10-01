Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5127FE5D
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgJAL2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbgJAL2o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 07:28:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AFC0613D0;
        Thu,  1 Oct 2020 04:28:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so4214260pfk.2;
        Thu, 01 Oct 2020 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdFfszEFg+9Y0mvLhElhzYRXmvD0D1SVXUuvXh8QwZ4=;
        b=Q8WmUFrIr/vc603KGTrAmH4cx8UN3Ns0p7FV9d6oV5G0E1UzW2wcIiKTGzi/psXe0F
         dbYbCtnVnsep5+BlbHWMxUST09bcWmkT5/DlEasfOfYdjVErM4OLqFXwE1anqT36Of46
         wkU7w4dCfExHzBvLmM5QCQMLzRdRxnG1CSJrhx1Co6XcyJukk03V4RRlKnb4NIXbBAiA
         jf1jzIBvMaHEfxkvHIRXHLSIZlJBo0JMCluU5rqH+wFWA9elNqu9sIokczXBmUDPo3su
         n76qt4Pq8eWh4ueXAplBInEYIeWhZnIJlHMIZftRjnGTu9F3JxzBCDpxqB5Y0rkUCz+x
         XRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdFfszEFg+9Y0mvLhElhzYRXmvD0D1SVXUuvXh8QwZ4=;
        b=i34XKCenPSAcDdPPp8M+Khi/nzSg8vTO8rLV9gz+u1aJ0nCBAtqB/PTt1ejQA/P6P/
         V7RlSZK47EBPB/emL4gGD3PmbZInuijTalpjk52aBNzJw8rCxqsoKOd7dyOMkksx8IkX
         J0Dbnk8nHEu4qoBR3TBSpw+hObSjBFE5KZx2YiyshGGxA9L60ndlOC9oJVis71625Hmm
         Sx6V1YaN6lN/SPs1SVB80X1JKPccNew9Pa5kZ5XQeA81s0kPKMHzzI4XukBZym4uE2X7
         tnxbUMd3dXjNWUO1natPtcA1QagF64IgvcYBbout1Ul7SUSqQ2USvAN4Ok2q3UB1aTW1
         6XPA==
X-Gm-Message-State: AOAM532bgU5Q9UQaOg8dHB7V088bd4wygFbahWYWuwwgGRyT1X+zT26a
        TtMCnqvnF9NNmOZ3Nt9NOYCcwY4suxdOEGlWDqE=
X-Google-Smtp-Source: ABdhPJxo9xb5Y/FPu8g8kJ6peODTF6LK6ttQzuwFH2GQul5cR5TkHOeuFJgkfgM8IzutagCPnnpWe3UnBvrCt6BBy/I=
X-Received: by 2002:a63:906:: with SMTP id 6mr5779235pgj.66.1601551723753;
 Thu, 01 Oct 2020 04:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com>
In-Reply-To: <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 1 Oct 2020 06:28:32 -0500
Message-ID: <CABqSeASwCXaP_vNe1=E3EeWAApFYiB1S5xEb9BdH10b0rn0Q6A@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     Jann Horn <jannh@google.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 5:24 PM Jann Horn <jannh@google.com> wrote:
> If you did the architecture enablement for X86 later in the series,
> you could move this part over into that patch, that'd be cleaner.

As in, patch 1: bitmap check logic. patch 2: emulator. patch 3: enable for x86?

> > + * Tis struct is ordered to minimize padding holes.
>
> I think this comment can probably go away, there isn't really much
> trickery around padding holes in the struct as it is now.

Oh right, I was trying the locks and adding bits to indicate if
certain arches are primed, then I undid that.

> > +                       set_bit(nr, bitmap);
>
> set_bit() is atomic, but since we only do this at filter setup, before
> the filter becomes globally visible, we don't need atomicity here. So
> this should probably use __set_bit() instead.

Right

YiFei Zhu
