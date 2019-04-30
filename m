Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE710062
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2019 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfD3TkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Apr 2019 15:40:17 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43233 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD3TkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Apr 2019 15:40:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id w196so6793328ywd.10
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2019 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9hapJfe16PyJZQNfi17Kkf8yv+f1SqUnJbmE8AnYr4E=;
        b=pz1nHFqIzMz7SkqEfjLv9j53AdOex0KJr1Jjv40jel6TDuOtHLUc1IyvYybLp8+Rg8
         SeJCdRW+CcTZYMz97kCsU9qZOMj6GbXBY1FhwQTPRoVkXET6lGsi/we5FwlT4NN8ZgGV
         D9HvQnd4WUerLRjIl7MHMI+zIzOO1OvFXA9aqxKG1DZKYvc/wdLLXdlne9u8chp4JI7z
         uSfhgXP+waFbZ+Y+hEAPmfIAv5EQ8iLEFU/LAe+y+912hhXcECsVrLpd9P9lQ2PLIpaa
         q1rzWkiYHKuoIbD2Cmj8YoOlJZtAIK7eVdnUhNPAJr877KBNLYYtlhevOefACCm8g5v9
         QYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9hapJfe16PyJZQNfi17Kkf8yv+f1SqUnJbmE8AnYr4E=;
        b=P9+6UPFS/dSwMfPrNw5A0tX5eT+vlJhDosVnYaa4aoWIC3lJwn03uqkWs8npMQi33x
         qdyYj8TmDMeB4GHnYez6PQ7HqJq+lr8N0kkli/8B7Dmk5jDtLlBnHCc3fgkmv26sFx0S
         cbTtN8nWyxBCA+rNuGBO5xLGvN1hlOO5ZvTpPIgWOSmacjRAO988qcGHnGsec5IodKmc
         JE8jkKcGMgdDs+nRYYPZsAHGvvsMPefSt5JwCljHVIHJFvFilz3quXid6La0TDArC2g5
         22HDNtsOAJPgUIaI0YfAfHSMz+COjw1pAVSMXIZH8p9g8C1tQ2m4zO3O3FCtHGolfcPv
         O8CQ==
X-Gm-Message-State: APjAAAW0x4lq7G0mjirEnTlrQco/I76UPJUuHo7qz1no0ec7LdR4zbKL
        KX7WWE0Z22acMyAP+uzXmXIFUg==
X-Google-Smtp-Source: APXvYqxqKpnwgH9sBzyVrkWzckuTsdDNH71RQl9Qesa6m+dtdU+SW7zkJIti4k+R188J6xC/gHqb/A==
X-Received: by 2002:a25:1d57:: with SMTP id d84mr18191417ybd.40.1556653216257;
        Tue, 30 Apr 2019 12:40:16 -0700 (PDT)
Received: from cakuba (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id p3sm7840711ywf.2.2019.04.30.12.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 12:40:16 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:39:32 -0400
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Y Song <ys114321@gmail.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Subject: Re: [PATCH bpf-next 1/6] tools: bpftool: add --log-libbpf option to
 get debug info from libbpf
Message-ID: <20190430153932.7d741d4d@cakuba>
In-Reply-To: <CAH3MdRXFBsBdrmTc36yBs0Y0wcz4tOk-cBY4q6_s9bmtdnctyA@mail.gmail.com>
References: <20190429095227.9745-1-quentin.monnet@netronome.com>
        <20190429095227.9745-2-quentin.monnet@netronome.com>
        <CAH3MdRUQn=ycpcDLbLxGAZwGhnVMoD-avPPcSCopAtwof4czNw@mail.gmail.com>
        <d4f761c3-d133-4f89-44c2-a96c7f917571@netronome.com>
        <CAH3MdRXFBsBdrmTc36yBs0Y0wcz4tOk-cBY4q6_s9bmtdnctyA@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Apr 2019 08:31:53 -0700, Y Song wrote:
> On Tue, Apr 30, 2019 at 2:34 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
> >
> > Hi Yonghong,
> >
> > 2019-04-29 16:32 UTC-0700 ~ Y Song <ys114321@gmail.com>  
> > > On Mon, Apr 29, 2019 at 2:53 AM Quentin Monnet
> > > <quentin.monnet@netronome.com> wrote:  
> > >>
> > >> libbpf has three levels of priority for output: warn, info, debug. By
> > >> default, debug output is not printed to stderr.
> > >>
> > >> Add a new "--log-libbpf LOG_LEVEL" option to bpftool to provide more
> > >> flexibility on the log level for libbpf. LOG_LEVEL is a comma-separated
> > >> list of levels of log to print ("warn", "info", "debug"). The value
> > >> corresponding to the default behaviour would be "warn,info".  
> > >
> > > Do you think option like "warn,debug" will be useful for bpftool users?
> > > Maybe at bpftool level, we could allow user only to supply minimum level
> > > for log output, e.g., "info" will output "warn,info"?  
> > I've been pondering this, too. Since we allow to combine all levels for
> > the verifier logs it feels a bit odd to be less flexible for libbpf. And
> > we could imagine a user who wants verifier logs (so libbpf "debug") but
> > prefers to limit libbpf output (so no "info")... Although I admit this
> > might be a bit far-fetched.
> >
> > I can resend a version with the option taking only the minimal log
> > level, as you describe, if you think this is best.  
> 
> Thanks, I think providing a single minimum level for output probably
> better.

I have a weak preference for what we have here, because it's similar to
the kernel bit opt in (log level, stats etc)..
