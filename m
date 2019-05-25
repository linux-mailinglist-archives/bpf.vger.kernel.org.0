Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555C52A3A0
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEYJJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 May 2019 05:09:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEYJJT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 May 2019 05:09:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id e19so3497330wme.1
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=k/uq3QuHYJNZ9DfxUmqixLeELosy6Cl/suStGs9+peA=;
        b=JMZB+kZTa7DkZWF5rYFI3NSTTKsi63QvETkz2wndiIG3Cjivj4rAGQUDJuayoxYqpL
         N/Qo60TJr5Pet/fw/usNhJ/RANBWqGjFybVJtPGFIosq5KxI+syt4zErEjU8i0UrLUNl
         iHTR7kafvftMey83Cyi769OdIxwJ5RcM0AiguGoB6qy1lWGdnOiIhkQrrjpOGuB6GEYX
         jCu3ZRIzGWMjekzjt96Jpu5daOdgW40BBKLFQR96g8HmS9/fr6B8GidZ3bhTFzscth+e
         Ye94lOz0HqeF75epFlXyzKP+5dRKwopmom/xUMlNfweDSlkx+uBWdMCnGhMZFnIMpyYt
         Dnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=k/uq3QuHYJNZ9DfxUmqixLeELosy6Cl/suStGs9+peA=;
        b=arCz3Su4Lc1YQDiDw3X3RMzlm3I1N/9n8fC4sOdOxY/bpy7DFyJtmfNy6muVNIu5Yr
         aLy9P+PvPJ7jSlPUEW+jRIMOTlf9ctHUckHtrOShLGSdnDU4N7UC0VQmSIFEu8gFNY79
         UMHybw/RPyRPZxnkDzTPUUMl25JMgOWEvqDmmqnjZq90o8HBfVlN05PI0FTPLKaRjTP6
         3Iu4gEGzaRUXDxr86wjfzZCGO42fDT4rQL/SPhosi3E/JaGiZPzsvnxcHxVU1T0Sja8q
         I3sewIFlBepAeVOse3F7TRbbR1dP/lhn0v7c/Caow2gy9exP7f3/PAkYQUlt7EJXVAzb
         uBYQ==
X-Gm-Message-State: APjAAAW4p4SRNXUzpXvPp0SElL8dkafKaH8Bhk9xG2PvaqzW/JYYviNe
        L8e3C9Khm5mG13vEStdvGlRTkw==
X-Google-Smtp-Source: APXvYqxpKo0suvuOJXTNl3G3D7blNjblMNcQUinzwZxqmHGf87wAUdNOQ+YNxUSVhi+FMomvjIarhg==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr2726190wmk.122.1558775356841;
        Sat, 25 May 2019 02:09:16 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id l8sm3354097wrw.56.2019.05.25.02.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 02:09:15 -0700 (PDT)
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com> <20190525020736.gty5sdcu5jakffet@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH v9 bpf-next 00/17] bpf: eliminate zero extensions for sub-register writes
In-reply-to: <20190525020736.gty5sdcu5jakffet@ast-mbp.dhcp.thefacebook.com>
Date:   Sat, 25 May 2019 10:09:13 +0100
Message-ID: <87zhnagati.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Fri, May 24, 2019 at 11:25:11PM +0100, Jiong Wang wrote:
>> v9:
>>   - Split patch 5 in v8.
>>     make bpf uapi header file sync a separate patch. (Alexei)
>
> 9th time's a charm? ;)

Yup :), it's all good things and helped us reaching a solution that fits
verifier's existing infra.

> Applied.
> Thanks a lot for all the hard work.
> It's a great milestone.

Thanks. And I guess the answer to the question:

  "Q: BPF 32-bit subregister requirements"

inside Documentation/bpf/bpf_design_QA.rst now could be updated to
mention LLVM and JIT back-ends 32-bit supports, will send out an update on
this.

> Please follow up with an optimization for bpf_patch_insn_data()
> to make it scaleable and undo that workaround in scale tests.

Sure, will do.

Regards,
Jiong

