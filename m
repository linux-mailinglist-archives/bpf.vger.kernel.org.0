Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C139BFF2
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFDS5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDS5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 14:57:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E3C061766
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 11:55:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k7so15947410ejv.12
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faTCBu/IgJAv7kJ3ncbkfJ9LXqzYiewgOpbVEkseQoQ=;
        b=IyS42Doo9Ow3UbrJ9GtmUYqu7i2G8VQXArD0kpNGCnZ3L8fYc02geRIjlmB7cUCss1
         MwJHB+lWNhjYP7Fp0ZsYrxC7eR6JXDLhZSJG8JqrbV2XzMY+WYPreQje4DaPENCd0seR
         dmNmXT3TL/IqY/byVDi+UudvM8xsuncPzmS4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faTCBu/IgJAv7kJ3ncbkfJ9LXqzYiewgOpbVEkseQoQ=;
        b=R7Ll+CocATKTBY5lI/ejBxXDQZ/0VAV83HYASQs95bSqZFbzEXxf7uk8ee0VvkfWTU
         C+uJtNnXqcphZPvjL7ttlpYKZhOTbjHWsHXYQodTGkajw+TAy7I9gbSmfZVgqrGsm41v
         9aFOd0Js0UX7HSd08YTIuGZ40TCCXdyC9aJgxaILFOKWwVt2lACFrmTmTU+bq/DYHJP1
         FYiHPYOPm0E2oxXDq10nJVIEf/pnnhYX8jVbj5jG/VL3WD/IOUq1M4iIcJqoldBC953z
         Ovshln/92fB3CcL188TYkNuAvteR09P2JQu1WCWJZ3OtcLDidju6YSRtRZVP3+StXUQ7
         dXag==
X-Gm-Message-State: AOAM532T0YcIVMUdOloaAZrqmdZE8np3A6CtVBeDogfGi776B26ue6MI
        z1aX3++sDcRKirTGgOySPITiyfVo37lJeabMIRxYIA==
X-Google-Smtp-Source: ABdhPJyiVtmnO/FBHASsHL6vR/QNFvhD17DGyhTNBVTK0apJfLE9SD5TFdmElDCy5NYwYP9aHLDNcPWN/fr24w2Nr5A=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr5567984eja.108.1622832913451;
 Fri, 04 Jun 2021 11:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210602190815.8096-1-zeffron@riotgames.com> <20210602190815.8096-2-zeffron@riotgames.com>
 <20210603043421.3a4fsjbegcwy623f@kafai-mbp>
In-Reply-To: <20210603043421.3a4fsjbegcwy623f@kafai-mbp>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 4 Jun 2021 11:55:02 -0700
Message-ID: <CAC1LvL1DBqConArA14dtK=G8Xt==fkMdY7H5KAoEyexQjgq8PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 2, 2021 at 9:34 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jun 02, 2021 at 07:08:13PM +0000, Zvi Effron wrote:
> > +     data = xdp->data_meta + metalen;
> > +     if (data > xdp->data_end)
> This test and...
>
> > +             return -EINVAL;
> > +     xdp->data = data;
> > +
> > +     if (xdp_md->data_end - xdp_md->data != xdp->data_end - xdp->data)
> this one.  It is because the user input "xdp_md->data_end" does not
> match with kattr->test.data_size_in?  These tests are disconnected from
> where the actual invalid input is.  How about direclty testing
> xdp_md->data_end in bpf_prog_test_run_xdp() instead?
>

The first test is required because it's possible that the user provided value
for `xdp_md->data` could be greater than the user provided value for
`xdp_md->data_end`. For example, a user could pass a struct xdp_md that looked
like this:
```
struct xdp_md {
    .data_meta = 0,
    .data = 12,
    .data_end = 8,
};
```
We're moving the test and making it more clear what it's testing for in our
next patch version.

The second test can be eliminated by moving the test for xdp_md->data_end
against kattr->test.data_size_in as you suggest, which also allows simplifying
the surrounding code. We're updating that in our next patch version.

We're also addressing your other feedback in our next patch version.
