Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7528BBF
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfEWUo1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 16:44:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36731 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbfEWUo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 16:44:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id o2so4392378qkb.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uyaana4PXc4ejMDebW7jtkm0Ao+gQmvQ960Gba78bNk=;
        b=ngoKYvpD0MJKfOn2iT9k9sBv8flyGIMu5/aAZFv3p0YHEA1QhFdwYDezrPb3bq3lfU
         PduqRll4Qgaf4Ut4UeANt2H2SGpz6gB0maeK2C9oAoYX3pxraN4+Ho11G1PYeDfkmShR
         fnAQdn2JmfwCp1czfK0u42rTLl99H+xjtf4FJI1LzNvjWO75me1/ePjfsandMYhRpDQh
         SOiSk+SRUPiD7ByfcaDRrExdbf4XRBwykMJMK9Ps2QKQOCQRgTF+ENZtHMWMWpjXQBYO
         EdIbtal4NVKKCIe0Ha4g/fqcK73fokAK1dXBymu1e9uzHEn30ePCujLpFq2DtJGnuDnl
         W/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uyaana4PXc4ejMDebW7jtkm0Ao+gQmvQ960Gba78bNk=;
        b=Y5Z8QWoi0/jh7++sV5hV3vLlLxhUYtq1tNn5aYrrHQBwOI6h6YbLTjG7U+Ip2fvYLP
         4ikcaBMV1o7DbX8hP0aCu5OctJz7AsIZfUfRZvLb5m6YFpdwsvyjsMj2JJNpOLF0Y1/m
         g0WQBHKWSCeBRDbbJPRbyxqWdDbFKVYDdyB98vmDjz4AgVORdoBY8G0nZU71LPdbov9m
         prP1vxIJMvL0UP/zmmwsEhunPCHhNOl311Oe5cC6+OVqdZpfe9mUDxRtLB6l/FnLCgRz
         PLlcvgoTRWj+CxYj3E32sXhH11YUXt3XkMbeh3QU02ECsmffGrR6R6kIiSlaHdQ6acfT
         HT0w==
X-Gm-Message-State: APjAAAUGi+yk2opjOZhKJOtlD/Cn4GoiNcRMWA9J9SLDAVed/wX+fHXO
        ff8G6xbPoizCS39LWO/Yhqu/+Q==
X-Google-Smtp-Source: APXvYqyPGmQpKOnKTMZEVH5e8waTJAv0uMYbqCLdWIKy0FbNjVamD56SWl73FRVmWrw3WuaQGWWF7Q==
X-Received: by 2002:a37:c409:: with SMTP id d9mr36788684qki.125.1558644266314;
        Thu, 23 May 2019 13:44:26 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c18sm204020qkl.78.2019.05.23.13.44.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 13:44:26 -0700 (PDT)
Date:   Thu, 23 May 2019 13:44:21 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, oss-drivers@netronome.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 1/3] tools: bpftool: add -d option to get
 debug output from libbpf
Message-ID: <20190523134421.38a0da0c@cakuba.netronome.com>
In-Reply-To: <CAEf4BzZt75Wm29MQKx1g_u8cH2QYRF3HGYgnOpa3yF9NOMXysw@mail.gmail.com>
References: <20190523105426.3938-1-quentin.monnet@netronome.com>
        <20190523105426.3938-2-quentin.monnet@netronome.com>
        <CAEf4BzZt75Wm29MQKx1g_u8cH2QYRF3HGYgnOpa3yF9NOMXysw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 May 2019 09:20:52 -0700, Andrii Nakryiko wrote:
> On Thu, May 23, 2019 at 3:54 AM Quentin Monnet wrote:
> >
> > libbpf has three levels of priority for output messages: warn, info,
> > debug. By default, debug output is not printed to the console.
> >
> > Add a new "--debug" (short name: "-d") option to bpftool to print libbpf
> > logs for all three levels.
> >
> > Internally, we simply use the function provided by libbpf to replace the
> > default printing function by one that prints logs regardless of their
> > level.
> >
> > v2:
> > - Remove the possibility to select the log-levels to use (v1 offered a
> >   combination of "warn", "info" and "debug").
> > - Rename option and offer a short name: -d|--debug.  
> 
> Such and option in CLI tools is usually called -v|--verbose, I'm
> wondering if it might be a better name choice?
> 
> Btw, some tools also use -v, -vv and -vvv to define different levels
> of verbosity, which is something we can consider in the future, as
> it's backwards compatible.

That was my weak suggestion.  Sometimes -v is used for version, e.g.
GCC.  -d is sometimes used for debug, e.g. man, iproute2 uses it as
short for "detailed".  If the consensus is that -v is better I don't
really mind.
