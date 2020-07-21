Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5922897A
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgGUTtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUTtN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 15:49:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E878C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 12:49:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so3614769lfs.4
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tlzw2qBtzBEUocVQtP18VhI3VjNjMDdoU+E5QrrpEA=;
        b=RB9ruW3j/3Q4H0YDkLlKecgv5d5TD+Jyo4sZBU799FudsbF2mdnt1uobgEiUp2/T8i
         O5Mn1vZuzfVj8dtcl/UJ4FOlcgkaQplbLKYMK3omRwYLrhFvIYijTSfsUTINLyTNym2j
         J9bLAIykyWRx86YGzRpfKh1qnHDvlmmJ8eB6WTkgsjvmN3kvlj5QIiEPeyz0XWZLMCXX
         2zAu5C68Z/QNfL5lTo0/cb0uB6WVK6fo9t2w6GwnIkGbxcrCi5JKGWKhuM0dctugQSDW
         IWCtwy4O41IG7by2S2s6uehhjgL2XiJjaWjZpbU8eGhXm3/bDGE4nVQKCX56aadN9TIF
         oIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tlzw2qBtzBEUocVQtP18VhI3VjNjMDdoU+E5QrrpEA=;
        b=ilp/dZbnHITryADN87PYC+4usC/gkZP//6Pn1Vj7D+77Zqnne/dgVRHR/o+EACtedB
         uTON2IemeTVPkth1jmVSMkm5HOHhIGb41rFCD1/0lqf4T/g58D7AqxOsgy6A6ZbQxUSB
         Z5PIgB4QKTbVXvEEtfCHIO1vmm/82Bm0iee2ojcZP+/b0yTIzjsxq0cGROmvN/MB06HM
         hgrJesrDTcXyXLdTEn3N0ggb+y09oltNJsObs6/eTXrjubVyaoafzbY/7g8GbjIT+dLr
         TNuLOwhL5bk9HAXYhP6aQMCpo2vdBYBl5tkn6vbXfoMVn2ydhZQ6qQ4OsCo0UROEyGPT
         8FZg==
X-Gm-Message-State: AOAM530rKL6LhTc2LSstEpDoctKNK7EuEmqrOZpoIJ5g1a9yy8GZTXsx
        jk1kXt/vvX832YYpgIsRshIMGJq7r4B8QGrKWKw=
X-Google-Smtp-Source: ABdhPJztT4Tz+7Ywex1AXUvZOIqsBZ0wYoiigLh1NyU6qGAkhoBiYL47iF4bnpwjSsLtB0Tb0h1JnJaim6lhMRBm7yo=
X-Received: by 2002:a19:a95:: with SMTP id 143mr14295023lfk.174.1595360951932;
 Tue, 21 Jul 2020 12:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200720101810.84299-1-iii@linux.ibm.com>
In-Reply-To: <20200720101810.84299-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jul 2020 12:49:00 -0700
Message-ID: <CAADnVQL+TNJy3abz2ki+jwvnLGVnApTBBe2GMyxy4Wi-t2JOXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_lwt_seg6local.sh hangs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 3:19 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> OpenBSD netcat (Debian patchlevel 1.195-2) does not seem to react to
> SIGINT for whatever reason, causing prefix.pl to hang after
> test_lwt_seg6local.sh exits due to netcat inheriting
> test_lwt_seg6local.sh's file descriptors.
>
> Fix by using SIGTERM instead.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/test_lwt_seg6local.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> index 785eabf2a593..5620919fde9e 100755
> --- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> @@ -140,7 +140,7 @@ ip netns exec ns6 sysctl net.ipv6.conf.veth10.seg6_enabled=1 > /dev/null
>  ip netns exec ns6 nc -l -6 -u -d 7330 > $TMP_FILE &
>  ip netns exec ns1 bash -c "echo 'foobar' | nc -w0 -6 -u -p 2121 -s fb00::1 fb00::6 7330"
>  sleep 5 # wait enough time to ensure the UDP datagram arrived to the last segment
> -kill -INT $!
> +kill -TERM $!

Applied.
The test doesn't work for me anyway:
Ncat: Invalid -w timeout (must be greater than 0). QUITTING.
selftests: test_lwt_seg6local [FAILED]
Ncat: Since April 2010, the default unit for -d is seconds, so your
time of "7330" is 122.2 minutes. Use "7330ms" for 7330 milliseconds.
QUITTING.
