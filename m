Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38DC682B0C
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 12:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAaLCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 06:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAaLCB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 06:02:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5C2D161
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 03:02:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so40474414ejc.4
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8VrMNoFf6IyxRtvbDL9jkW7Kyp2j06lYArxVjpBPcg=;
        b=fLSP9lkbej1XYv8RD7eCFeDV2IggoGD3nf18kGipJ17E4Mk2Cpx5NCbtQwq7qSlepj
         xhY3CKSTW1d1Ig2BkN0Hkx7Wk43a1R+KA21lYXozroUa/vvq1jruNSYwSnTAVwqMnVGC
         K+c0vqQ0C2eRdTa3W47gKnYcrX+OSzc5gJakR6VRl8D3cXvwI9I/h1pZ2wFGMkyFHUuW
         mBe8qD4GeiGBJBzWcxVTnXVinSpiYN6+LALZgp9Ajcsvs98uWjtzvWwPcK8NVOByzPc+
         +yENCUHl0M4FQgtnJPm8I4Tnqzrld6pMSNcarsh1CCGLs6zDlNjDoJQYIdtbuxyBeY+A
         Mmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8VrMNoFf6IyxRtvbDL9jkW7Kyp2j06lYArxVjpBPcg=;
        b=4uTJq5nU967Ewrgua/Bh+PN7sourntWRcfqlLNR2MN6P3RpF5pqpREn/UxOmMAWMwb
         ZnUgJHxa7fJUDuaI7YTd4Nd8PRuYULvSoQeiF2nA6jb52ADFgRC/qWUWWXr/0QP/paNH
         i6T+vzFi+6sU9v0lYw+K+8Dxsufv8pTQLwpRY1dUMXJN5ncMSr5S5Jj3EGsLO3nCFY4u
         7ffLFfYaEkBWSfdAaBU6Yz5NVYdTwxnNNXHxKQhUwdz4a7Pp4hB2Afk7x9cU6WWXvrpE
         F4k0yl5GV9t4vnZ4wUZ3x18rpI4+rfebhLnhcKx+iETINH3021NBGAzf5CvqVUoKSTFU
         mlEw==
X-Gm-Message-State: AO0yUKUge5DAlfDFTZiJ7UwDULKFjVo6O4hIppp7pSo3IlWtSvs7ow/V
        z3VfD67HLh+ca6skjmbVjZ94Vw==
X-Google-Smtp-Source: AK7set+TmADU3hI/4RRwerFpalmpz7TdvleTi1J5sZiprpy7e8wirlT16FpYAjNyosHP6IioYI/q0w==
X-Received: by 2002:a17:907:8a25:b0:88b:f26d:7b25 with SMTP id sc37-20020a1709078a2500b0088bf26d7b25mr3038835ejc.28.1675162918551;
        Tue, 31 Jan 2023 03:01:58 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709063ad000b008779b5c7db6sm8158514ejd.107.2023.01.31.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:01:58 -0800 (PST)
Date:   Tue, 31 Jan 2023 12:01:56 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftest/bpf/benchs: Add benchmark for
 hashmap lookups
Message-ID: <Y9j1JMi3D6saJBLL@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-7-aspsk@isovalent.com>
 <CAEf4BzbS-2QdXxU7i0y0oDqBd==FuGxg+mSAMaA3q4Nc2pYTMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbS-2QdXxU7i0y0oDqBd==FuGxg+mSAMaA3q4Nc2pYTMA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/30 04:16, Andrii Nakryiko wrote:
> On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> [...]
> > +
> > +       switch (key) {
> > +       case ARG_KEY_SIZE:
> > +               ret = strtol(arg, NULL, 10);
> > +               if (ret < 1 || ret > MAX_KEY_SIZE) {
> > +                       fprintf(stderr, "invalid key_size");
> > +                       argp_usage(state);
> > +               }
> > +               args.key_size = ret;
> > +               break;
> > +       case ARG_MAP_FLAGS:
> > +               if (!strncasecmp(arg, "0x", 2))
> > +                       ret = strtol(arg, NULL, 0x10);
> > +               else
> > +                       ret = strtol(arg, NULL, 10);
> 
> if you pass base as zero, strtol() will do this for you

Thanks, I didn't remeber this!

> > +               if (ret < 0 || ret > UINT_MAX) {
> > +                       fprintf(stderr, "invalid map_flags");
> > +                       argp_usage(state);
> > +               }
> > +               args.map_flags = ret;
> > +               break;
> 
> [...]
