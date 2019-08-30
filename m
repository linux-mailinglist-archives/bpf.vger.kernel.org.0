Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8317A334D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfH3JBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 05:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfH3JBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 05:01:43 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8CFC05E740
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 09:01:42 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id f11so3821554edn.9
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 02:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4h8WrjQdM9TLiy2pzR4Fbw4xO6EScWPkpYQPOfK5FA0=;
        b=pgI9Jf5MIKLDioGwtvkVPbjNky8LQugltp5se4h6zW0fiO1ygUQyi2HRGXRtoSwixS
         sGhpC7z8vsbmIBSNqzZpIFCF7C5Am98gNOzwC8X05UEfK6rBL2pCd5LwcQsZ4h6yy1in
         BWjxiCI+cKlxMEnCgi1m7WrNHsdixZk1AmjtNfylJgku/IV/mOFcWriNzm9LlHSfwwPK
         NkrwVRi2qjjk3OCwdf09Q5AimQZrGyivfE559FBjxuMYEUkCpTGgr2QTiHxvcvBLEW+j
         d7+hN6TTs9ua1HWmAcCjM7O8BiJt6qjszQeypBCeUwn7yOltxWp+k8yh/4azka5BRD6V
         bQuw==
X-Gm-Message-State: APjAAAWRXTeZ/f5NPF6+WgZosffRjqyBOUi6pxQJRZkO0N/qTLK0fmU6
        NDhDYd+tbiwAyonUG4ONY+2eCG9Yu9d/mMA+jANwChbaeiJrwR0eKABZGzDAoFWWml1GCbQeewh
        zPKDeM9Yiv1JV
X-Received: by 2002:a50:9e6c:: with SMTP id z99mr13877068ede.200.1567155701263;
        Fri, 30 Aug 2019 02:01:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRht67HVHFMDdakpBzdjgBlWne6bCfAipjrj/w/wJWdRagzWXkLcFOX8fjburCrT20aGmv5A==
X-Received: by 2002:a50:9e6c:: with SMTP id z99mr13877041ede.200.1567155701068;
        Fri, 30 Aug 2019 02:01:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u14sm893269edy.55.2019.08.30.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:01:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9D8C181C2E; Fri, 30 Aug 2019 11:01:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Julia Kartseva <hex@fb.com>, ast@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, rdna@fb.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: auto-split of commit. Was: [PATCH bpf-next 04/10] tools/bpf: add libbpf_prog_type_(from|to)_str helpers
In-Reply-To: <20190830064722.GJ15257@kroah.com>
References: <cover.1567024943.git.hex@fb.com> <467620c966825173dbd65b37a3f9bd7dd4fb8184.1567024943.git.hex@fb.com> <20190828163422.3d167c4b@cakuba.netronome.com> <20190828234626.ltfy3qr2nne4uumy@ast-mbp.dhcp.thefacebook.com> <20190829065151.GB30423@kroah.com> <20190829171655.fww5qxtfusehcpds@ast-mbp.dhcp.thefacebook.com> <20190830064722.GJ15257@kroah.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 30 Aug 2019 11:01:39 +0200
Message-ID: <87zhjrdo24.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Aug 29, 2019 at 10:16:56AM -0700, Alexei Starovoitov wrote:
>> On Thu, Aug 29, 2019 at 08:51:51AM +0200, Greg Kroah-Hartman wrote:
>> > On Wed, Aug 28, 2019 at 04:46:28PM -0700, Alexei Starovoitov wrote:
>> > > On Wed, Aug 28, 2019 at 04:34:22PM -0700, Jakub Kicinski wrote:
>> > > > 
>> > > > Greg, Thomas, libbpf is extracted from the kernel sources and
>> > > > maintained in a clone repo on GitHub for ease of packaging.
>> > > > 
>> > > > IIUC Alexei's concern is that since we are moving the commits from
>> > > > the kernel repo to the GitHub one we have to preserve the commits
>> > > > exactly as they are, otherwise SOB lines lose their power.
>> > > > 
>> > > > Can you provide some guidance on whether that's a valid concern, 
>> > > > or whether it's perfectly fine to apply a partial patch?
>> > > 
>> > > Right. That's exactly the concern.
>> > > 
>> > > Greg, Thomas,
>> > > could you please put your legal hat on and clarify the following.
>> > > Say some developer does a patch that modifies
>> > > include/uapi/linux/bpf.h
>> > > ..some other kernel code...and
>> > > tools/include/uapi/linux/bpf.h
>> > > 
>> > > That tools/include/uapi/linux/bpf.h is used by perf and by libbpf.
>> > > We have automatic mirror of tools/libbpf into github/libbpf/
>> > > so that external projects and can do git submodule of it,
>> > > can build packages out of it, etc.
>> > > 
>> > > The question is whether it's ok to split tools/* part out of
>> > > original commit, keep Author and SOB, create new commit out of it,
>> > > and automatically push that auto-generated commit into github mirror.
>> > 
>> > Note, I am not a laywer, and am not _your_ lawyer either, only _your_
>> > lawyer can answer questions as to what is best for you.
>> > 
>> > That being said, from a "are you keeping the correct authorship info",
>> > yes, it sounds like you are doing the correct thing here.
>> > 
>> > Look at what I do for stable kernels, I take the original commit and add
>> > it to "another tree" keeping the original author and s-o-b chain intact,
>> > and adding a "this is the original git commit id" type message to the
>> > changelog text so that people can link it back to the original.
>> 
>> I think you're describing 'git cherry-pick -x'.
>
> Well, my scripts don't use git, but yes, it's much the same thing :)
>
>> The question was about taking pieces of the original commit. Not the whole commit.
>> Author field obviously stays, but SOB is questionable.
>
> sob matters to the file the commit is touching, and if it is identical
> to the original file (including same license), then it should be fine.
>
>> If author meant to change X and Y and Z. Silently taking only Z chunk of the diff
>> doesn't quite seem right.
>
> It can be confusing, I agree.
>
>> If we document that such commit split happens in Documentation/bpf/bpf_devel_QA.rst
>> do you think it will be enough to properly inform developers?
>> The main concern is the surprise factor when people start seeing their commits
>> in the mirror, but not their full commits.
>
> Personally, I wouldn't care, but maybe you should just enforce the fact
> that the original patch should ONLY touch Z, and not X and Y in the same
> patch, to make this a lot more obvious.
>
> Patches should only be doing "one logical thing" in the first place, but
> maybe you also need to touch other things when doing a change that you
> can't do this, I really do not know, sorry.

As someone who has been asked to split otherwise logically consistent
patches to accommodate the sync, I would very much appreciate it if the
process could be set up so this was not necessary :)

-Toke
