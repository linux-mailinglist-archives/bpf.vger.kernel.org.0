Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5C13FB1
	for <lists+bpf@lfdr.de>; Sun,  5 May 2019 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfEEN01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 May 2019 09:26:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36217 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEEN01 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 May 2019 09:26:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so2580541qke.3
        for <bpf@vger.kernel.org>; Sun, 05 May 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=Wx8/Qn4lhOzjepZEXkLBZ+w8/WHG8jhLCLZePQswk3nuOkWjV3N5eH3aZKCgdybogp
         7/TReM/N6U6Lw8RYN3lD4pnUWUG8h7F81NJCRUMPZDWBZMOfV4oc9MoHAgMWetH1nZpI
         OHyXUY0uszNgLft1e5rlQxJbPefuA34AZXXgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=XCg87r2jsESMRibARbGWkpNIU71QlFgaRoaEKEix6W7sbMwDQdkvxTquJYzw0dtsgW
         z1aXsQKNiXc3x5biJd1Cz29A/Ip01u7Et0y71vT9aSsUID5iuY1c9jRsdKmG5HoEvrDg
         flHh0Bpb/KOM5kNL3rm9nU6OR2cAOeYFxcTIDUyqGfYSpSh/8jv41IHIxmCdod5EXbCA
         WlQh7QI6ahUZKpjyZcNvzc6/OCVB2ZIT97YIX6H2kXTeEAplVfDf/s34geQi5i9Po2sW
         MS+IPjbyeP1ZQDioRfN/rGU6Auksi/ze9j4FwqoEtX87kD61EoN6HQeL5EVIt2/ky0Vp
         Hm1w==
X-Gm-Message-State: APjAAAUX5YpdoZrl3lM4TIDvm+t1l4RoMU7h+L/RQJ23x9RI9BTgyKWi
        s5C6d1XUtdvwNE/KoqOYMgYIMQ==
X-Google-Smtp-Source: APXvYqzN3LNC9F4r23JL3m1ARyAewSM1naLPRx+StaQtVcEsebbIkaf5I9yTOOJzVD+6xM/cfuUBLQ==
X-Received: by 2002:ae9:df43:: with SMTP id t64mr15613710qkf.250.1557062786462;
        Sun, 05 May 2019 06:26:26 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id k127sm4921838qkb.96.2019.05.05.06.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 06:26:25 -0700 (PDT)
Date:   Sun, 5 May 2019 13:26:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190505132623.GA3076@localhost>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505091030.GA25646@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:
> > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > should have barfed on this change.
> > 
> > fixed, below is the updated patch inline, thanks!
> 
> Please resend as a "real" submission, doing so in this format is a bit
> more difficult to apply.

git am --scissors can do it, but no problem I will send as a formal
submission. Thanks a lot.


> 
> thanks,
> 
> greg k-h
