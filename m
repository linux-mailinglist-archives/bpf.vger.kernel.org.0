Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5037C27F5FE
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgI3X1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 19:27:22 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60299 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729617AbgI3XZ3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 19:25:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7DAB696C;
        Wed, 30 Sep 2020 19:24:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 19:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=U
        Uv/ycHKk0VmQ9jog/Fu42gbcuiVRCdjLJbHAyQkcMA=; b=ivLuxv4Q55f1KpcuS
        +cwKbc+rREjpPqhNs+z6z6vjquCNIcj/E8v8Busu2VtTJ16rgl8jXLEQjMa40b1D
        ReI1SEVJg30OsggeJY9AInJEz/bd9bbSxaQL8V53iPVzbmGxfhHD4MFwlVStlBwX
        aqRjDgpgWhsmi6JhdsEugslTbAqczxPq5QFgGIMssgwiFRxmgLKxaHJkOqd33zb+
        MuLo/0gCKdB1eeNJEp1lVmD+y7WeJqOoItZ5ISqVZOD0fTGSEijlsx7T3sNwFh83
        WW3/9jZdXT1zRIKZKd3Sk1e9PtvZJzDJjWvFXIMzjAN9WPjctu81EuHOPrC5sD1E
        x0vuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=UUv/ycHKk0VmQ9jog/Fu42gbcuiVRCdjLJbHAyQkc
        MA=; b=NiIOs+5J+ArBtzNXG9vmBi8u7JjTh87LIZHMCkPCZH2PN4i+5633Sijoe
        ouCmaU+C+bvwasFuxNWPFL/DlP77sTXfxsoK/g6MYoImqKTejhm4xwtx2ecJqSJh
        /Kx4k2Mcpn9Z2DX63sPvi270Mnu6uRs7l3eoAbVYL8VAhJGK9kq3fswLVBPOxisp
        Fw8s46jiYOVH8cy0i5Ov/yR7Ljysxlup7/9XHm5HZF8PLwyMPrqZOaDFyZ5kYp9i
        8rNnWKVPpINdn/CzafZq0hA4cAHRvJuhacxWIfGhv2QDoGvdLz9m39k+2YlpcD9D
        8anKe2R87M80SjVwpdVQinitLhbIA==
X-ME-Sender: <xms:yhN1X9H9snWiSjRa58ptv2FGpb0ejiIwBgz0Vxgf8oUxCBJTFTGSTw>
    <xme:yhN1XyX04W_qDhH9mL9Eyd4Nv8JDhhy3Nwt2FaPz3AlwpsKaBLdIXHCc6r5UofNA8
    MdXk4zdRwpO886sjl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpefhuedvvdelieevgeegjeeukeeuleejtdejfeetfeeujeefvdeltdethffh
    ueekffenucfkphepjeefrddvudejrddutddriedtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:yhN1X_KJCsR49coiERRTusNVu4W6LEty5EA-9M2lS4RyJADZ5xQxmA>
    <xmx:yhN1XzGUZzwU4FtsJ9oTnlhQyjxNwOvP4Ao75Mv1L6MQTWidE9f2Mw>
    <xmx:yhN1XzXjrR73t55KZ2EZyMOBk2zVvk1dFlU4TuiKiVpURYMIQ09lbA>
    <xmx:yxN1X0t5pelLdbmhvSRf_uhEPTbbqZwnT9SjA1c3AMwZl1T6qsRQScXk04aFhoda>
Received: from cisco (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A15E3064610;
        Wed, 30 Sep 2020 19:24:57 -0400 (EDT)
Date:   Wed, 30 Sep 2020 17:24:56 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Jann Horn <jannh@google.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20200930232456.GB1260245@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
> > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
> > > >>        ┌─────────────────────────────────────────────────────┐
> > > >>        │FIXME                                                │
> > > >>        ├─────────────────────────────────────────────────────┤
> > > >>        │From my experiments,  it  appears  that  if  a  SEC‐ │
> > > >>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
> > > >>        │process terminates, then the ioctl()  simply  blocks │
> > > >>        │(rather than returning an error to indicate that the │
> > > >>        │target process no longer exists).                    │
> > > >
> > > > Yeah, I think Christian wanted to fix this at some point,
> > >
> > > Do you have a pointer that discussion? I could not find it with a
> > > quick search.
> > >
> > > > but it's a
> > > > bit sticky to do.
> > >
> > > Can you say a few words about the nature of the problem?
> >
> > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("seccomp:
> > notify about unused filter"). So maybe there's a bug here?
> 
> That thing only notifies on ->poll, it doesn't unblock ioctls; and
> Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So that
> commit doesn't have any effect on this kind of usage.

Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
we don't have a count of all of them, unfortunately.

We could maybe look inside the wait_list, but that will probably make
people angry :)

Tycho
