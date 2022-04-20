Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F005A5080B1
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiDTFpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDTFpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 01:45:52 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458F1DA5E
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:43:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y85so770543iof.3
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4y2HkU8+633gGcp6OXqlun2ZpDlWLuWm5gSlkljdK+A=;
        b=H7sSxgfW3mkXz/bzQ9rCx37kq1ILf1isHtDEStZflwtw1TDAiSWgt/RTIuB1AJe7sf
         LfQ+exb8W1eOX6+6ejgPc2gaNP7oabKZbIYGDxN5J3zcM3z0iKzyVjCX8E2l7qjnBhjp
         3xHutZTZULFJtK8ZSofDRp8Rx62/oWl9lPmsQFwB4K64OwBLSJg759cYL2OvW9+5L8cL
         jcut/jZ0wVOtC62IMvkT9gwRtDu2L9ZY0UM56s0QxbkfZEKPloaLwTidJPVcYjVPsUeL
         rDE+/Sbv16QOAfu0lBEwIeH7VtA9yVQKc17sEoQRZ5H16gblGXQNUSE3ZgbkCB+n3XVz
         6Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y2HkU8+633gGcp6OXqlun2ZpDlWLuWm5gSlkljdK+A=;
        b=Nf4IZSZpax6dWYQkF+ZvzVU1upfDalaqYkbmGhsezShXh+iTLwmaVh8Xgdj/qphozd
         bn1SpZrkNX7jwNc5vX0aIg+Ixk8OMTwOZvGE7hi+mVWaRqSnPE6PSwoQv9YLusBT/OXR
         4diRDYkrQ5l8InqejU7UmOZL2lzKNO7ju67lJ3txod3l7hderRaAbsiMjWZ0Y7EtwHam
         jG+7Q4ZshmP2K5SvdA9vYh0k1SAkoGCTKh89dwlFxNETp9bdWCgIU3DIeJbGZRzFU4IB
         mpWBfSRwKOhMGrh0z890uNSKQhqOHIyaA29oBMTjeu/AktEbRCr3UR6sYBU8FPpSCTOo
         +v2Q==
X-Gm-Message-State: AOAM533b/X9uY3lrE9tWOt9EPYoGReMQl8q40u6Nn+upKRYFeWD1ePEt
        GKHI1js1phBwnaZtWuYABi1ftt1MpfL8GkEvWwg=
X-Google-Smtp-Source: ABdhPJwzlDpTWIpXHgUw2m+lOIkptAun3O7cJ7oblYqEC7rbXjkC5BuCc4Tk4p4rVfX+vsAfqdIS71ldFXGtyWvgX3U=
X-Received: by 2002:a05:6602:3787:b0:654:9cab:b681 with SMTP id
 be7-20020a056602378700b006549cabb681mr5408237iob.154.1650433386997; Tue, 19
 Apr 2022 22:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160346.35633-1-grantseltzer@gmail.com> <20220419160346.35633-3-grantseltzer@gmail.com>
In-Reply-To: <20220419160346.35633-3-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Apr 2022 22:42:56 -0700
Message-ID: <CAEf4BzbS-3d=FWvuG_VnPvokXBBcpV_KJ0XgBt+kCXPzz=tiMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] Add documentation to API functions
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>
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

On Tue, Apr 19, 2022 at 9:04 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds documentation for the following API functions:
> - bpf_program__set_expected_attach_type()
> - bpf_program__set_type()
> - bpf_program__set_attach_target()
> - bpf_program__attach()
> - bpf_program__pin()
> - bpf_program__unpin()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h | 100 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
>

[...]

>  LIBBPF_API enum bpf_attach_type
>  bpf_program__expected_attach_type(const struct bpf_program *prog);
> -LIBBPF_API void
> +/**
> + * @brief **bpf_program__set_expected_attach_type()** sets the
> + * attach type of the passed BPF program. This is used for
> + * auto-detection of attachment when programs are loaded.
> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + * @return error code; or 0 if no error. An error occurs
> + * if the object is already loaded.
> + *
> + * An example workflow:
> + *
> + * ...
> + *   xdp_fd = bpf_prog_get_fd_by_id(id);
> + *   trace_obj = bpf_object__open_file("func.o", NULL);
> + *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");


bpf_object__find_program_by_title() is deprecated, we shouldn't use it
in documentation. There is a lot going on in this example workflow
(and workflow itself is using generic API instead of recommended
skeleton). Let's drop it, it might just be adding to confusion.

Just mention that expected attach type has to be set before BPF object
is loaded (same for program type). And that should be enough. In most
cases user won't ever have to use this anyways, IMO.

> + *   int err = bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
> + *   if (err != 0) {
> + *     // Object already loaded
> + *   }
> + *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
> + *   bpf_object__load(trace_obj);
> + * ...
> + */
> +LIBBPF_API int
>  bpf_program__set_expected_attach_type(struct bpf_program *prog,
>                                       enum bpf_attach_type type);
>
> @@ -707,6 +780,29 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
>
> +/**
> + * @brief **bpf_program__set_attach_target()** sets the
> + * specified BPF program to attach to a specific tracepoint
> + * or kernel function. This can be used to supplement
> + * the BPF program name/section not matching the tracepoint
> + * or function semanics.

Not sure what you wanted to say with the last sentence?

How about something along the lines:

"... sets BTF-based attach target for supported BPF program types:
BTF-aware raw tracepoints, fentry/fexit/fmod_ret, lsm, freplace" ?


> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + * @return error code; or 0 if no error occurred.
> + * An example workflow:
> + *
> + * ...
> + *   xdp_fd = bpf_prog_get_fd_by_id(id);
> + *   trace_obj = bpf_object__open_file("func.o", NULL);
> + *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");

same about find_program_by_title, please don't use it; and same about
the overall example, it's not succinct enough to fit in a doc comment,
let's just drop it?

> + *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
> + *   int err = bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
> + *   if (err != 0) {
> + *     // Object already loaded
> + *   }
> + *   bpf_object__load(trace_obj);

like here, we don't check error, setting a bad example :(

> + * ...
> + */
>  LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
>                                const char *attach_func_name);
> --
> 2.34.1
>
