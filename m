Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0401B82CF
	for <lists+bpf@lfdr.de>; Sat, 25 Apr 2020 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDYAkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYAkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 20:40:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458AC09B049
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 17:40:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so11809989ljg.5
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2YKAgPkeVUCIZIAz63LiOU28ZXsukyOaPS/56ZwV5VE=;
        b=HWEJYPiYExVkH5ZZ1ucaDMxUwG85eReZOMw4572wXxe3n3SvhPjy6sXcihkEFvLf+V
         jSrFWfXXv7Ty11dCiGKi44YWpsCV2R+Tc2Rmmft5u3mR+x3dUGdF0H9xlzDSn4oA25fe
         pCkWp4KAoJ/AJ/VFFC1Mg8xD9fBryXS0kP5n5F5JILiJ2yR4Sc3oNdkulfM260kOou54
         fte2afGMo5fYCn1K595WmOQ/1er9sn5LoDPFqRo13CeNZtnVhKoS0fIxKhwHYDjnKgad
         Ia5kiABkWJKV5lZDvUZTZpIUIJv0lnS9gS2G6jkTu+xuVmBNw+BcCkRmv9+mcndeE+H2
         p1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2YKAgPkeVUCIZIAz63LiOU28ZXsukyOaPS/56ZwV5VE=;
        b=iIpXN/RgCZ7LFoDj5h9xRiYXGzhBiSOjzNEBGh341rxlwVZAQkZjZLSeZXxFYRFJzL
         I8G0UDPCXpntIRDnWWF3QgZMFqBGeDzY0nr45MZoGbFEkgfPBm3w5QIiGGDfsrL6rrcs
         YhJnitU3Qez/vJkiawYNgwEl9+q+x+S0wyUZZDZr8NV6FdpxTXPBzGFUYYePLcNQL9QO
         yp6iekB99oa0SjcULc1lszjJ1tPaYLcmXDGyoOZ9EH8PKW4KaSUceY5U+k8z1EYb4Om9
         U6Mvz+zAagJ3/A/0LJPVuI0I3wsC8P9E8wLuPnhXZoDr0pvwFiBsGAj9vVHk7Sjt3IJf
         Onkg==
X-Gm-Message-State: AGi0PubhCn6zXbWr4mouC2R95fNAJqEsvhC+Z6bB9NcrHDjwvljRVKJd
        xamnonD8a8cDn4jioJ5KYHtlJASmMIIzuq5f1pg=
X-Google-Smtp-Source: APiQypIJ7Uz0+RyGK0vNr2qEZjKtoAdGUsSChdE/ok2uj6RVWQveq+9FQhC55zbEFoQmgbmyCbsu2+mY8J7MeRnfUsM=
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr7068269ljm.215.1587775221918;
 Fri, 24 Apr 2020 17:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <158773526726.293902.13257293296560360508.stgit@toke.dk>
In-Reply-To: <158773526726.293902.13257293296560360508.stgit@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Apr 2020 17:40:10 -0700
Message-ID: <CAADnVQ+gu9KPU6ydJ-MJDqYiJoRBWGFtpfK5a8J0Jf9s7r-8PQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Propagate expected_attach_type when
 verifying freplace programs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 24, 2020 at 6:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> For some program types, the verifier relies on the expected_attach_type o=
f
> the program being verified in the verification process. However, for
> freplace programs, the attach type was not propagated along with the
> verifier ops, so the expected_attach_type would always be zero for frepla=
ce
> programs.
>
> This in turn caused the verifier to sometimes make the wrong call for
> freplace programs. For all existing uses of expected_attach_type for this
> purpose, the result of this was only false negatives (i.e., freplace
> functions would be rejected by the verifier even though they were valid
> programs for the target they were replacing). However, should a false
> positive be introduced, this can lead to out-of-bounds accesses and/or
> crashes.
>
> The fix introduced in this patch is to propagate the expected_attach_type
> to the freplace program during verification, and reset it after that is
> done.
>
> Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Applied. Thanks!
