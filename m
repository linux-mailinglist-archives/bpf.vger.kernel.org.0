Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46F33E275
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 00:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCPX65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCPX6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 19:58:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2AAC06175F
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 16:58:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k2so39191620ioh.5
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IklMf9X34RfFB2tD5VBL6tlFQuCAFSd3dj+6sxly+A=;
        b=NCG+NcBXFzlueVVDEW9J9YjBNnzPpY5Cjw5qCl393AdvUcFzcbdxlqKkHcdGk52iF+
         d5X6yUChO9YoSWyrJgZkuSz7LLF9OFDpxZJWuhuoONPWaw+rK9MYe1L94r+C+f2ukCEW
         T9c9N9+UJN1DZGpv7/94RHbfAzbSQXqV3e+lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IklMf9X34RfFB2tD5VBL6tlFQuCAFSd3dj+6sxly+A=;
        b=uRZ65FA/haFymz4X4F/0IufHHPf3LjO8yQr32WIvtImG0fBwreqZ1e3fzncN2pdlfn
         dWtEqBnYra6MvhYLxXSHKiucwACDnuOGm3iGIQvbL+TN2ZbP9v7d7TGJuM4d9lnTmuSa
         LhoHwJBm/4XsqV4dtHf20ZS4u5HHtz1sIG+d0RUYBT7TTWC4hoxDl/usVHA83iTIM8CV
         MGLw2/Mdo9S8W0JuJJOunhkATUucFWMampXPm4e3RMVATTJH3GOYBeScd9hcxdsIfyAZ
         yjZbFWYM1Pg4+eXJEnRSC9/RUCV3bF0GTqYHCl6lTs279i4VDUYzU0nOTayTjSvkABIQ
         FaTQ==
X-Gm-Message-State: AOAM532HZut/DU33sQVb3vOEE2vOO2X0MZT4ntt1LWoxs2BRaPluRbFG
        /uY0myU1MdTYUkKlLqaWlloZQtRbr6s4fcl9CmZnkg==
X-Google-Smtp-Source: ABdhPJypZMQsaLnE/8+WaJbv9a9Wlrdij5WiDNuBRMzDTmnV5GeqmjdcedhThVo9TT0P8SRqefrtd9iK7bZtdRAxGfQ=
X-Received: by 2002:a02:cb48:: with SMTP id k8mr900560jap.52.1615939121345;
 Tue, 16 Mar 2021 16:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 17 Mar 2021 00:58:30 +0100
Message-ID: <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > +               struct bpf_map *map = reg->map_ptr;
> > +               int map_off, i;
> > +               u64 map_addr;
> > +               char *map_ptr;
> > +
> > +               if (!map || !bpf_map_is_rdonly(map)) {
> > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > +                       return -EACCES;
> > +               }
> > +
> > +               if (!tnum_is_const(reg->var_off)) {
> > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > +                       return -EACCES;
> > +               }
> > +
> > +               if (!map->ops->map_direct_value_addr) {
> > +                       verbose(env, "no direct value access support for this map type\n");
> > +                       return -EACCES;
> > +               }
> > +
> > +               err = check_helper_mem_access(env, regno,
> > +                                             map->value_size - reg->off,
> > +                                             false, meta);
>
> you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> use check_map_access(). And double-check that register is of expected
> type. just the presence of ref->map_ptr might not be sufficient?

Sorry, just making sure I understand your comment correctly, are you
suggesting that we:
1- skip the check_map_access_type() currently done by
check_helper_mem_access()? or did you implicitly mean that we should
call it as well next to check_map_access() ?
2- enforce (reg->type == PTR_TO_MAP_VALUE) even if currently
guaranteed by compatible_reg_types, just to stay on the safe side ?
