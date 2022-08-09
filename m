Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE358E098
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiHIUFb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbiHIUF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 16:05:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55C1C114
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 13:05:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h138so10474533iof.12
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2s4SK74fy8qe/GpFXYFbwoSCigQIrVQuR2vx1+RtWHA=;
        b=cLAOxsGlj/iBiMZQ7CNYGbMvK8plDKZXM7Cnp9JoaKYv8m94l2vyAx9W+aebPEPGX+
         j6JE3kPYTC2W/fbclCyy3ZJ9msRJX+TB7ckIpZG5BXIx4WFfG17Fu9eW+UAxk8uLQlYC
         4Xr5fhk/mNuwLqRQmOp+sgcIj8Dy6Oe8fdrSPv4fuTsj/DqpCAOSjsM0CmZ7rrVl19IP
         ABU6cKoD83xMiN4hAnF11zfr/5eGKd1seTR8WOlTgP2Ps0MF4g3x+2UFBjSDC7b4gJQj
         QWdWNnLFgEDHzTOI9JhHuPK2fQVL1r2IwOnDW7WdrXqrktIuLgudu0woIkYjSIrJS27s
         Hvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2s4SK74fy8qe/GpFXYFbwoSCigQIrVQuR2vx1+RtWHA=;
        b=tHYmc91uu1gxcyl2f1DzBUg+tPcmFafVLm3Pg5QNfL1lj/oZGIjBbDyR2DF1guBAmr
         cXWuj2uRarT9soAg+TSVftguLobUnw7qKrnzvqO57twPSu5CZNzswY24eWkXcWKl0z7f
         b00U+uN7QVX7BARcgI4XPZ45JlvPZdFliSfbESBjPNJH/pPVfb9w7CPcPIspqfa6CJ3C
         WtgV9pbxziAVVCHkK+0zYTzENCzKts5bMIlH9unv0lXf0Pucdiu44pXRqZcT4tlQ6gHC
         7fp7IRJf0K+pHMMYLPKRIJB6VqC+MbhWjPX6/VNMuTmb//CzXIlhST3ey4PxVNOOdVHB
         mHHg==
X-Gm-Message-State: ACgBeo3yWmi3E3wPnbWB4zffdXwOzYcZ0w5cWRaGE4PE8AlHyCm229zN
        HGqZf8lklSPb0ZcxjLab+Rhgy5Uq5QVMA7YX26I=
X-Google-Smtp-Source: AA6agR4wcwUsSlNK8maRuQlX9hy7z9RyE4Y6bs7rxj6+q/eGQ14o0TGt5hHM4SAYN3Zaz+ZFY2Y7mmkIw1MiFaEvjko=
X-Received: by 2002:a05:6638:210e:b0:343:1748:910 with SMTP id
 n14-20020a056638210e00b0034317480910mr4385072jaj.116.1660075525103; Tue, 09
 Aug 2022 13:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220809140615.21231-1-memxor@gmail.com> <CAADnVQKBajvLk7L5Oe8jX9fp3XQznsLY_Od9sP2_z_ox-eMMXg@mail.gmail.com>
In-Reply-To: <CAADnVQKBajvLk7L5Oe8jX9fp3XQznsLY_Od9sP2_z_ox-eMMXg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 9 Aug 2022 22:04:47 +0200
Message-ID: <CAP01T74yjNq3SMOL_ZH7DMvOGWvb1aF18uNUoww9D9rgXir7Sg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/3] Don't reinit map value in prealloc_lru_pop
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 9 Aug 2022 at 20:49, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 9, 2022 at 7:06 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Fix for a bug in prelloc_lru_pop spotted while reading the code, then a test +
> > example that checks whether it is fixed.
> >
> > Changelog:
> > ----------
> > v1 -> v2:
> > v1: https://lore.kernel.org/bpf/20220806014603.1771-1-memxor@gmail.com
> >
> >  * Expand commit log to include summary of the discussion with Yonghong
> >  * Make lru_bug selftest serial to not mess up refcount for map_kptr test
>
> hmm. CI is still not happy.

Yeah, I'll try to check for it differently.
