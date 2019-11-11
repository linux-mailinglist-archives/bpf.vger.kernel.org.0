Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A8F819A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 21:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKU4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 15:56:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKKU4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 15:56:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id e3so8306791plt.7;
        Mon, 11 Nov 2019 12:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KM4VRIxAE0QmHwuwob8cnofCE9z3QlA4QFjFNITl20k=;
        b=UtgHSqT2FYzxLchLUj+cDdJ4QayV34mMCPO2TT+rl+lKYFwhpn7HSV3zNjwP89BKe+
         Jv6JdYOG8NoD3FiW87KJmz5wCwza7MAKCDUOppxPM4mP/kbqxpEXL9hotpusLOg3qUOF
         zS3/sxtzzbvq1ndJ+SvbszFfOen3m/MgSG0F5zc7stLVHF48MqflC9/n/rdXMqpf5sBr
         eVfVqAdeFKjDSo3NNV0/tFUd07+w2+Qz9bZvRpu1lsWN5z9byIuZcHOMwZbu+kajU51u
         2fXo1MZCLK0jfbuHOPtqz/d7t9jD+7wrKCdCRWQEUlVikmpFzoLlq7Dr22DUaZD3rc5i
         mofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KM4VRIxAE0QmHwuwob8cnofCE9z3QlA4QFjFNITl20k=;
        b=McBGnDtfcXB/MwOCIP98BbUzzRT0nPww73v6RQr4Ba1kwr0lov+B89aGg2Gja734a9
         OxvLiXwukyuTMFdpMseHRdrEspSRtiHcA8nculkLiBG/+QTFEn4OxVppJjRCJcsQN/1M
         Q4oe5jN1I3DK695WSpzrPRAm1mYXBNOEbrBgYAe4zk0OLV1jph4iKaEWHEoRUW5slUso
         pxKt2hSLZJC7O7QEfCrZpVtAKpfqli9b4juiscV3gfHB4N5cKIiBw8KERuKTD9rzD6At
         taQU+TVEGLP/RVkh0B+lSN2laemj7VsMovea1yJ7wla175ObAWkJMj0UHr+1EMechN9s
         1flA==
X-Gm-Message-State: APjAAAWrc9ytSiCliPLbhsBWwiuQ/S6GttwoezpkXB4cBvOM4EhjgBVi
        sWRTUki+iGmk0M5a9XhvMnU=
X-Google-Smtp-Source: APXvYqyOYv9WWwxaXpfdo91g01uvUkfqfyfT/BhS65Uh7OjGA9krSCCbGX7dx72I83hhyFCvvteuHw==
X-Received: by 2002:a17:902:8bc9:: with SMTP id r9mr26156880plo.299.1573505801083;
        Mon, 11 Nov 2019 12:56:41 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::a925])
        by smtp.gmail.com with ESMTPSA id s24sm16560764pfh.108.2019.11.11.12.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:56:39 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:56:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@fb.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191111205636.vbp3j3ok72rwr4os@ast-mbp.dhcp.thefacebook.com>
References: <20191111131252.921588318@infradead.org>
 <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
 <20191111204243.GV4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111204243.GV4131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 09:42:43PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 11, 2019 at 11:47:28AM -0800, Alexei Starovoitov wrote:
> 
> > Some of the patches I think are split too fine. I would have combined them, but
> > we try hard to limit our sets to less than fifteen in bpf/netdev land fwiw.
> 
> Yeah, the series is getting too long (in fact I have a whole pile more).
> 
> I tend to try and not re-arrange a series if I don't have to in order to
> avoid breaking things by accident when shuffling them around. But yes, I
> could avoid some things by folding and re-ordering.
> 
> Dunno, maybe if I'm forced to do another round :/

I would just land what you already have and keep iterating on top if necessary.
The core pieces were ready back in August. There is always some room for
improvement. Your other static_call set can also land now. I'd like to play
with it too.

