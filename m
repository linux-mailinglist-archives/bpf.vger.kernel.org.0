Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C590563864
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGAREc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGAREb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 13:04:31 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EEC15A35
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 10:04:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c137so2272664qkg.5
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hXuRZcfvRMR9rJVFvr7RTikdpO64e3raNqg1i/r/h0=;
        b=SM1OIhIVqW9DtXkHMmavT9A01upnuonHi73bJwhI/aXrhLFDEUexpugGoqANDbqlC0
         tfH0s3L6QShi6ae2aiVnfbY0BLai6UDFAlbMsnhjtw7yUBqoYRRq1+uRl99m2AxvCgBo
         Of7dvSbV2CDYjYOvy/7XPywuq/q03q/gnUfVSAAkXD/5/K99UvV+LZzxCPu0qpKTbj3K
         wHN1XArMOaAKPRhwO0KNcaDxXqFH9Hl0q0yp05HAef+K3AQcSVD37DHaktJhR5+KUtqu
         K2A3x0kbZfLXA6Zy7AOXkHlLhIP0t1EmnK95JuC4a7Ev+PaepVadROxvB0WzeFbiZGwQ
         +SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hXuRZcfvRMR9rJVFvr7RTikdpO64e3raNqg1i/r/h0=;
        b=S6B78lR8/c67egNNvHJyJyfrEiYbk2kZRoYAwOPTRmjYFJ6MmtDeTAtJAs7gAhxCpQ
         c2Ef8b6KSDLhGzLioitHlZGFvT0jLe0tKZ/Db1XLyKqAYOGlecGRRsXUrX+7q0SGZF27
         p9UdiZ/mVZh8Bky9PICXrami787988arCTX/UbNVIdx70QwzaegrQTHP14dGqH4FE27e
         Z1jouWamZZ2zYdZQRY7F3UAB8mhCy2scTAn+YBUwb2opNgP0/0fAb3K1DZp1NOEbNDBc
         TKbJYxXohIz7EQUdFnvg3nOeyXiE9zUZhmBpiKMCQtPg/4qBxEPtfgYq2uV+b+2d0auM
         p2FA==
X-Gm-Message-State: AJIora+8tTIDAbaHrz3LokhC7GigkNWMzINHJcME5vRFR1eEadk11uh2
        5tucA0oXlhe6w0VuK34oVtvBdGd+UHvJMkQDgVsugw==
X-Google-Smtp-Source: AGRyM1t5GCf+qzJqflEVmv8Niyr7/14fsb8ppfR0xlUP3cIWiENnNn4vI9mOqPq2uz2dOITCo1XfeOrJNLujgE6ZGvg=
X-Received: by 2002:ae9:e854:0:b0:6af:dfb:4755 with SMTP id
 a81-20020ae9e854000000b006af0dfb4755mr11271712qkg.669.1656695069119; Fri, 01
 Jul 2022 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220630224203.512815-1-sdf@google.com> <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
 <CAKH8qBv=3hMzpTy=K-n5+rObPhkns0gjJibVFHhNgG7ojrrMVQ@mail.gmail.com> <bf5f2bcb-9c19-f5a7-f74c-cee874def883@iogearbox.net>
In-Reply-To: <bf5f2bcb-9c19-f5a7-f74c-cee874def883@iogearbox.net>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 1 Jul 2022 10:04:17 -0700
Message-ID: <CA+khW7iQUu-enWyg25r+HGZhNnJ62y1GZ_-vidnE7e_dMVXhgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 1, 2022 at 6:22 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/1/22 2:16 AM, Stanislav Fomichev wrote:
> > On Thu, Jun 30, 2022 at 4:48 PM Hao Luo <haoluo@google.com> wrote:
> >> On Thu, Jun 30, 2022 at 3:42 PM Stanislav Fomichev <sdf@google.com> wrote:
[...]
> >>
> >> It seems ENOTSUPP is only used in the kernel. I wonder whether we
> >> should let libbpf map ENOTSUPP to ENOTSUP, which is the errno used in
> >> userspace and has been used in libbpf.
> >
> > Yeah, this comes up occasionally, I don't think we've agreed on some
> > kind of general policy about what to do with these :-(
> > Thanks for the review!
>
> Consensus was that for existing code, the ship has sailed to change it given
> applications could one way or another depend on this error code, but it should
> be avoided for new APIs (e.g. [0]).
>
> Thanks,
> Daniel
>
>    [0] https://lore.kernel.org/bpf/20211209182349.038ac2b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

Thanks for the reference!
