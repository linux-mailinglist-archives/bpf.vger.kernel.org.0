Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381D5788B3
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiGRRpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGRRpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 13:45:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAF92C648
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 10:45:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so22726019ejb.0
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MRdrFo28TR4LurP4lCnHGHEaC3rEK7GdUO57c59o6mc=;
        b=lDYEQWntwda38G0bDQ5PLOKUPAPlBTIyFms+20v6Og8QfkCLkNrwIWSGS+GCowkHAK
         x58KzNb9UdPMafxWfoa4gSqsfxHPdM4lFgycGsU6X+q7d9oLOmG3xY4yoY7aubeb4qN1
         MJ0Qon5GVYVqOYsMAyT18N3WdMU0pFto0Bg7KHzc4SdBzvTUWBzVhRycJtzDZ9X/fkn8
         4AxR247fxX8+4JeJa9EJnueFdC9zLmT/9yy3WA1DQFhn//gGH2FCaBUxl5B3dNbYtV3G
         lz2kiELutyx0Bim1xpmopCfMLHFoU2aItWf9J1bHW2qLf6BKkUGBWG8VbSfdfBg2Mv+0
         Cwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MRdrFo28TR4LurP4lCnHGHEaC3rEK7GdUO57c59o6mc=;
        b=MpfcJkHFDgFyVuudIVRUMCgLM4WKrmNONC+v1eYwqdhN+DaOspEwOI2jIzKnr/mM+G
         j1Fi1pZFB/LgJYFaogOAg+Kfrxu2/q4vRVDMA+eawTbI+FfKJs7FD3J+c2Qk2Mk1YxYL
         D5uTlrepYBbp/jPiW/VylYrNaTo1GErVJuFsqmpzc62C4MOE1OT3Oql05VO1jFxZuped
         vOuliNi5ptyXW6c/TNZDlLnkG12P2p4ozWaFjcIhUr1+h6haRpUEgJITQHfmt3qjxySK
         +cK42WYR+F6MwEqWc2xZdtJUDMo+F4HZQMfrYzrjorLORhawDxLb3cwLWnKraboNyj3S
         kGTQ==
X-Gm-Message-State: AJIora/NIXdfjhKNdXCLSlNwB/F+vVKK6nG7WRArTdMlNiBxeQgM/6pY
        9msU2K0F/YKyD5kewbmnnzLnYb2Rz4x8cL/yhC5E6Q==
X-Google-Smtp-Source: AGRyM1ufo1/+2GlWO4KYoUagjLmU+QJzXSuwkGBRKgJOM5E+60YifKWhe4z0nYYdJnzEChww1WA4OX4b5tez33J5zXo=
X-Received: by 2002:a17:907:b0a:b0:72b:3176:3fe5 with SMTP id
 h10-20020a1709070b0a00b0072b31763fe5mr26034326ejl.48.1658166341017; Mon, 18
 Jul 2022 10:45:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Jul 2022 23:15:29 +0530
Message-ID: <CA+G9fYsd0DaBtWk5cFxPhfM_cZRMQk3MbaxMRN3WJ-yNjAkp7Q@mail.gmail.com>
Subject: perf: util/annotate.c:1752:9: error: too few arguments to function 'init_disassemble_info'
To:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        perf-users <perf-users@linaro.org>, bpf <bpf@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kubakici@wp.pl,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

with reference to other email thread on perf build failure on Linus mainline
https://lore.kernel.org/bpf/20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de/T/

I see perf build failures on stable-rc 5.18 .. 5.4 with this error [1]
and also noticed on today's linus mainline tree.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

steps to reproduce:
--------------------

tuxmake --runtime podman \
        --target-arch x86_64 \
        --toolchain gcc-11 \
        --kconfig
https://builds.tuxbuild.com/2C7oWWWYOYGFtqq4SWX1yG4a2Ne/config \
        debugkernel headers kernel modules perf

Error log:
-----------
  CC       event-parse-api.o
  CC       staticobjs/btf_dump.o
find: 'x86_64-linux-gnu-gcc/arch': No such file or directory
error: Found argument '-I' which wasn't expected, or isn't valid in this context

USAGE:
    sccache [FLAGS] [OPTIONS] [cmd]...

For more information try --help

and

  CC       util/annotate.o
  MKDIR    util/
  CC       util/block-range.o
  MKDIR    bench/
  CC       bench/sched-pipe.o
util/annotate.c: In function 'symbol__disassemble_bpf':
util/annotate.c:1752:9: error: too few arguments to function
'init_disassemble_info'
 1752 |         init_disassemble_info(&info, s,
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from util/annotate.c:1709:
/usr/include/dis-asm.h:472:13: note: declared here
  472 | extern void init_disassemble_info (struct disassemble_info
*dinfo, void *stream,
      |             ^~~~~~~~~~~~~~~~~~~~~

[1] https://builds.tuxbuild.com/2C7oWWWYOYGFtqq4SWX1yG4a2Ne/

Best regards
Naresh Kamboju


--
Linaro LKFT
https://lkft.linaro.org
