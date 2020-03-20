Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB818D6A7
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 19:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCTSRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 14:17:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58229 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgCTSRv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Mar 2020 14:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584728270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XcqKNMIDmZgPXYKMJ/Z4y5dJuyK3gRelFg7cu60qx90=;
        b=Vly5xPipKB9SDA0XroPayMC/1+qNmnclPU8m1BCOAlCphU6+C/EVOMHUyrRJZieT6AvwJs
        J53IPU+p60x4iBVewz1AqPCzLaYrJ0UUMSN8stG8Q4xgDLJO61KfgxXaqTej7dcubYxDmS
        dzx2+3yGepthzrHLzW9Uxl06OnccUVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-fb74A8vEMGSFk13hAgBiow-1; Fri, 20 Mar 2020 14:17:49 -0400
X-MC-Unique: fb74A8vEMGSFk13hAgBiow-1
Received: by mail-wm1-f71.google.com with SMTP id h203so1954468wme.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 11:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XcqKNMIDmZgPXYKMJ/Z4y5dJuyK3gRelFg7cu60qx90=;
        b=FSLHw/Y25McRhswSEz7LSdtANfF22P9wQhpn6CVx8guQbZDIyh+Q1QgjQIzFLbbOoF
         qVh5v07BUBFCe/mDiWJZIhDgvt7+vRwWyja3HXssv5I7YBrv7JASwdqpu2CHobJLqaAN
         eGp7Oqajs+k3w7G2b4yzXKk2NuZ4D87Lw2cGQ5sjDQZaAwbyidwFlFgKRSc+luUuj0tY
         ZlOgmuX5z9m34mKQ3r9ApIVkC06c4M0/759AMCm0A9DwaNu36ICVjktMiFSxfG4CVq8T
         OOEJcv1RLoWG0TV1U6hRXeC63OKHEitxhKlUOtmFHEw9YHfeAFftuuplPeb+tTmCbcBD
         DkFA==
X-Gm-Message-State: ANhLgQ1LB67rWQGxe2FS9OYWeIVhH17thEeKcCCHB1oSc7520Hj2uLK/
        c/C+0S779sz4EVNXcT6i9W+iH9W0kv8AxafnndqwjdsVSQ9D+7LTd/Tjcdfdn8IXu4fjo+VmC/r
        Wgm3edbPzLqoj
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr11848290wmj.117.1584728268086;
        Fri, 20 Mar 2020 11:17:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCWblzkc0Q5TxfiBZYEQdIUHVCXwcaIu4835meoXOtk1aHCSdpgU/vbX2In/qVA8hCJEPzTw==
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr11848266wmj.117.1584728267891;
        Fri, 20 Mar 2020 11:17:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w3sm3200398wrn.31.2020.03.20.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:17:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C034180371; Fri, 20 Mar 2020 19:17:46 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200320103530.2853c573@kicinski-fedora-PC1C0HJN>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk> <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN> <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Mar 2020 19:17:46 +0100
Message-ID: <87imiy6gc5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

>> > If we do please run this thru checkpatch, set .strict_start_type,  
>> 
>> Will do.
>> 
>> > and make the expected fd unsigned. A negative expected fd makes no
>> > sense.  
>> 
>> A negative expected_fd corresponds to setting the UPDATE_IF_NOEXIST
>> flag. I guess you could argue that since we have that flag, setting a
>> negative expected_fd is not strictly needed. However, I thought it was
>> weird to have a "this is what I expect" API that did not support
>> expressing "I expect no program to be attached".
>
> I see it now, not entirely unreasonable.
>
> Why did you choose to use the FD rather than passing prog id directly?
> Is the application unlikely to have program ID?

For consistency with other APIs. Seems the pattern is generally that
userspace supplies program FDs, and the kernel returns IDs, no?

-Toke

