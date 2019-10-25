Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07192E5595
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfJYVBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 17:01:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40226 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJYVBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 17:01:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so5325382qta.7
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVtJbf7MZXavUT4maIFA36ngDvG4G9FC0wEaxZ0JntQ=;
        b=YbjOu/DZGU3dJfjGyqH61fdCqzJ0ggr5TjJONO3wdjA6Bzv0C6QwWTVoL8vWqDU7o2
         cuavwa/HX4uHZRYP0j85w8SbIxBbJfqKH0rFr69AXJGO6YAg+/Pg81xPum1ykbkgbDbD
         /vCPH7PESoCHPckdhf7RiuIHS5KjXMF10EPjzA04JvWWIq/1uJ3BXLRMLdBXfEp1X/me
         KzOQ3gUGqNXqHn9lA2pctwv2ik3YqxUlHDTZ31UvzcSxADvBfr2PlRdtlyswNz5Tn/fy
         isoe65baja1LpNFfHffK0mOkKCQzCiHajH6bUIkQU0g/c0qBhBEDQ7HBmmUzt5nuZiiP
         XJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVtJbf7MZXavUT4maIFA36ngDvG4G9FC0wEaxZ0JntQ=;
        b=dzh9ZkjKtAaE0jJiK0SFye7WwnVHY6e/5INEkTrT/nmoRG4ekNPWk4r70PRzpy1mIZ
         mnzACraxgNylQfi5HOH+yvDoWsprTy1r056RTLWzpQCq6MWUsQm27E9mFgeH35tT20q4
         rX/f6U5tSWHb9bdsooUfuYuAuZAt42ecPs65swax4IMYDKDaNK4lCqZwA2l6KsLzMke9
         pkik+jYWqTw/LTtwjEyokIWeDsj+OBlt0RJ//rhKqtwm++UH7wrl0w0pnyJ+iv5hnVyB
         Aoh12v7Ok0pRuzr8TyXa378Wjw1gHzNabJy/QaMySHD/nete1ThxieIAfNebDbM0gGG1
         HkyA==
X-Gm-Message-State: APjAAAV52cfKygvwJFxnhNQmJLyEFpqjNfx2m9fZwzmgLcUjz5I+HRv+
        1zaceibP7JH+OSAUT9SuQXdA++VB2y2qwheSpIkR0hwr4g0=
X-Google-Smtp-Source: APXvYqzCoCkZ4CbgFxXb7ecIBIlUOqUU1JTG18P8MrkzTMkxVk1tpOgNB2QM8EAYjyxRrJm/ynlZF3zBCED3/lx9cYE=
X-Received: by 2002:ac8:199d:: with SMTP id u29mr5060709qtj.93.1572037312147;
 Fri, 25 Oct 2019 14:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191024184205.1798-1-iii@linux.ibm.com>
In-Reply-To: <20191024184205.1798-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 25 Oct 2019 14:01:40 -0700
Message-ID: <CAEf4BzZJ4XAOd-9ZYqD-XwBfidFdKnwcqcUu9EjkZuv8bOE5JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: restore $(OUTPUT)/test_stub.o rule
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 11:54 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> `make O=/linux-build kselftest TARGETS=bpf` fails with
>
>         make[3]: *** No rule to make target '/linux-build/bpf/test_stub.o', needed by '/linux-build/bpf/test_verifier'
>
> The same command without the O= part works, presumably thanks to the
> implicit rule.
>
> Fix by restoring the explicit $(OUTPUT)/test_stub.o rule.
>
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 59b93a5667c8..9d63a12f932b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -89,6 +89,9 @@ $(notdir $(TEST_GEN_PROGS)                                            \
>  $(OUTPUT)/urandom_read: urandom_read.c
>         $(CC) -o $@ $< -Wl,--build-id
>
> +$(OUTPUT)/test_stub.o: test_stub.c
> +       $(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

Looks good to me, even though we never pass $(CPPFLAGS) to any other
objects, so for consistency we might want to drop them.

But either way:

Acked-by: Andrii Nakryiko <andriin@fb.com>

> +
>  BPFOBJ := $(OUTPUT)/libbpf.a
>
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
> --
> 2.23.0
>
