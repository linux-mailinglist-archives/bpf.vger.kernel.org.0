Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4A27F5A5
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgI3XF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 19:05:57 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43469 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730528AbgI3XEB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 19:04:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C3B1D9E6;
        Wed, 30 Sep 2020 19:03:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 19:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=X
        tI1tB6xpmgOimSVGwz0nFQ2Aj6bySi3TmcGUJtNKDE=; b=YjqRrknkoRvFSexBK
        tWIx+0K77PM+g0q6zBEER8Mt7P/9XETbBwjWGh7driOG1BR0O0UdsvYOnDTthRRc
        ZtHljtdgwIjc9VuXtrIcDEuKUTe6uU0+QeVPTIGm6he4GXmt5AsJuNGuoQP8On+1
        T7L2sLAcw2uTnMsQOtb02PP3pBoDmPd2KeF8pXrWX8dmLM/KPPvGosaD6qnSEHdA
        orkj6krPdLFTt3LWnJgHvHVeIQu8JeHkZR5UPUJiZ9AKn7+zmcYtk9vPPYQAIW67
        8rfHmpgRHqQbLV/Gi6um89WtsDHHNE9+JHhA5SK3BDv7cZeA3D55UAstc6hoS8a2
        1ddsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XtI1tB6xpmgOimSVGwz0nFQ2Aj6bySi3TmcGUJtNK
        DE=; b=NQaPjYn0VYYM79zUlgVbI/HpUJfbGPk21tjYqk0fMqaQ+2xwfkmvV6TIS
        pWiapS+Fyws9Z5VApdOhGuBwN/Y80rPEh+aeZiXrI373/amdb0AVVblB4/LcZqzR
        EX7YCPM9MOVnsisrs8onXRMXzKU/1SA8FJrP+OGAh5APWHI6LdFxOepBQLBNFo+Q
        s0DQWONJfi5XBUNM+PSLrC9UyGEAm5fPUVKhJUUCHwnm2vwIfMm0NXkV+ykLZA1D
        ZB8lJ2B+MBD/0IkkzdX8wFplAMhfKL6aJEq5E4vvQ9aRHwPQcBoaTM0hkJ4wMSm3
        0Jabe0jwdeHE+vpIy58XYf+HZv2jg==
X-ME-Sender: <xms:wg51X5uj72nxaBN5fR3YSdO-qFbV_CB9A-VQ8jm8XnNanmrnzt8aLg>
    <xme:wg51XycH4OzurAZwKlJz8r0cp0T0_Pct30D0uSeq7bp5L_Cugw99nNA6sHHmSOQUz
    yT9SdbT9jsYltIC0PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpefhuedvvdelieevgeegjeeukeeuleejtdejfeetfeeujeefvdeltdethffh
    ueekffenucfkphepjeefrddvudejrddutddriedtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:wg51X8xtJIO64eSz3Q3M080KKG4JsHDj7Xiqdk0jQHSVU5u4kJcJjg>
    <xmx:wg51XwN0G_bf6PI8i2pSy7aoPH3QowMLTbZ9x9Tu8Penm-lNtPlKbQ>
    <xmx:wg51X5_b8jwQjzwKX0LihTsNRq6mbv5nYniW8rg6cHHtW5WkhK8iqw>
    <xmx:ww51X9WkyHuURkpU7U4m7pwqtnbF1rpD9uOCHNOs5bTWUUeKuWgnsGDTfR_ZJcnT>
Received: from cisco (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1083A3064686;
        Wed, 30 Sep 2020 19:03:29 -0400 (EDT)
Date:   Wed, 30 Sep 2020 17:03:27 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20200930230327.GA1260245@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Tycho,
> 
> Thanks for taking time to look at the page!
> 
> On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
> >>        2. In order that the supervisor process can obtain  notifications
> >>           using  the  listening  file  descriptor, (a duplicate of) that
> >>           file descriptor must be passed from the target process to  the
> >>           supervisor process.  One way in which this could be done is by
> >>           passing the file descriptor over a UNIX domain socket  connec‐
> >>           tion between the two processes (using the SCM_RIGHTS ancillary
> >>           message type described in unix(7)).   Another  possibility  is
> >>           that  the  supervisor  might  inherit  the file descriptor via
> >>           fork(2).
> > 
> > It is technically possible to inherit the fd via fork, but is it
> > really that useful? The child process wouldn't be able to actually do
> > the syscall in question, since it would have the same filter.
> 
> D'oh! Yes, of course.
> 
> I think I was reaching because in an earlier conversation
> you replied:
> 
> [[
> > 3. The "target process" passes the "listening file descriptor"
> >    to the "monitoring process" via the UNIX domain socket.
> 
> or some other means, it doesn't have to be with SCM_RIGHTS.
> ]]
> 
> So, what other means?
> 
> Anyway, I removed the sentence mentioning fork().

Whatever means people want :). fork() could work (it's how some of the
tests for this feature work, but it's not particularly useful I don't
think), clone(CLONE_FILES) is similar, seccomp_putfd, or maybe even
cloning it via some pidfd interface that might be invented for
re-opening files.

> >>        ┌─────────────────────────────────────────────────────┐
> >>        │FIXME                                                │
> >>        ├─────────────────────────────────────────────────────┤
> >>        │From my experiments,  it  appears  that  if  a  SEC‐ │
> >>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
> >>        │process terminates, then the ioctl()  simply  blocks │
> >>        │(rather than returning an error to indicate that the │
> >>        │target process no longer exists).                    │
> > 
> > Yeah, I think Christian wanted to fix this at some point,
> 
> Do you have a pointer that discussion? I could not find it with a 
> quick search.
> 
> > but it's a
> > bit sticky to do.
> 
> Can you say a few words about the nature of the problem?

I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("seccomp:
notify about unused filter"). So maybe there's a bug here?

> >>        ┌─────────────────────────────────────────────────────┐
> >>        │FIXME                                                │
> >>        ├─────────────────────────────────────────────────────┤
> >>        │Interestingly, after the event  had  been  received, │
> >>        │the  file descriptor indicates as writable (verified │
> >>        │from the source code and by experiment). How is this │
> >>        │useful?                                              │
> > 
> > You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
> > reasonable.
> 
> No, I'm saying something more fundamental: why is the FD indicating as
> writable? Can you write something to it? If yes, what? If not, then
> why do these APIs want to say that the FD is writable?

You can't via read(2) or write(2), but conceptually NOTIFY_RECV and
NOTIFY_SEND are reading and writing events from the fd. I don't know
that much about the poll interface though -- is it possible to
indicate "here's a pseudo-read event"? It didn't look like it, so I
just (ab-)used POLLIN and POLLOUT, but probably that's wrong.

Tycho
