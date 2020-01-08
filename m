Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6EE134B92
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgAHTkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 14:40:20 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:3644 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHTkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 14:40:20 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 14:40:20 EST
X-EEMSG-check-017: 42325420|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,411,1571702400"; 
   d="scan'208";a="42325420"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 19:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578511994; x=1610047994;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5vtn4nl+vULDkbXvwPAZaK8U99nfGQpZnPOpY7Pr5FE=;
  b=Lo/Mml0zbhap+ALWEBhBX0jACG3dHFljtomSc1NRgvxLKAfyhnoAHtGG
   YX1+GbXp22dQtKkTPpqExnDCFHoPsFGwvxS+Kj7JIqQ1kkS3ejO1LiaZ/
   3qNpJ/mBWyC09srGZl/0k+cR2OamaiFgE56pLwguUsRyrDPo5Pst8H9A1
   USjObGuQznVcRgSdGPhL8oXcJ4+XpvbMExVXzFk7DnproffGBZNT2UIkx
   iocupJ432cclvV/bzYwBUJoGpQgrFVSIm1gvNwvmSNIDyw6hdT7RdVVv9
   3OuBvcvYJkzdjttpzCaNmuEF36LMWei3FZ1rtE3QQw+rVSsOBiUpySnZ0
   g==;
X-IronPort-AV: E=Sophos;i="5.69,411,1571702400"; 
   d="scan'208";a="37510737"
IronPort-PHdr: =?us-ascii?q?9a23=3ABvES1RU5jmv5HPC14ZHaSC+3pb7V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZhGEvadThVPEFb/W9+hDw7KP9fy5AipavMbK6SpZOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjfu8UMn4dvKqU8xh?=
 =?us-ascii?q?TUrndWdeld2H9lK0+Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrvxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zWErxtNvCDh8jMgy02P3qCNNn2YMbR22PA7?=
 =?us-ascii?q?WVMKTIsV+H/ugvOfWDZJcJuDbhLPgo//3ugmEnll8GYaap2pwXaHOjE/t6I0?=
 =?us-ascii?q?WZe33sgtIAEWcXuwoyVuvqiEeNUTRLfXa9Q7o85i0nCIKhFYrDRZitgKeA3C?=
 =?us-ascii?q?e9EZ1WZntLBUyMEXfycIWEXvYMaD+XIsN7lTwET7ehQZc71R6yrA/616ZnLu?=
 =?us-ascii?q?3M9yIEr53jz8Z65u3ImBEp6TN0D96S03yDT2FwgGwIXSY607xlrkBn1liD1q?=
 =?us-ascii?q?14ieRCFdNP//NJThs6NZnEwux+CtDyXB/Bf9iQRFalXNqmGzcxQcw1w9IVfU?=
 =?us-ascii?q?Z9FMutjgrZ0yqpHbAVjbqLC4Iw8q7G2HjxPcl9wW7c1KY9l1kmXtdPNWq+i6?=
 =?us-ascii?q?Fk7wjTCZXEk1uWl6m0b6QQxi3N+3mZzWqIok5YVBR8UaLfXXAQfkHWt8j25l?=
 =?us-ascii?q?veT7+yDrQqKg9Byc+EKqtXZdzllE5GS+n/N9TDeWKxmnuwBBaRyrOJa4rlZn?=
 =?us-ascii?q?gd3CHDB0UfjQAT8miJNRIkCieivW3eFjpuGkzrY0/29ul+sny7RFcuzw6Wd0?=
 =?us-ascii?q?1hy6a1+hkNiPOGUPMTwqkJuCQ/pDVuGlaywdbWB8CHpwp7c6VWeck970tf1W?=
 =?us-ascii?q?LFqwx9OYStIL14iV4YcgR4oUfu2g52CoVHnsglsmklzBBpJqKf31JNbTWY0o?=
 =?us-ascii?q?7sOrfPMGn94Aiva7LK2lHZyNuW5qcP6PsipFX5ugGpF1Qt/m573NlVyXuc4Z?=
 =?us-ascii?q?DKDAsPUZL0SEo38AJ6p77CaCkn+4zUzWFsMbWzsjLa3tIpBPEqyhK8cNdFN6?=
 =?us-ascii?q?OFGhT/E8IdB8ipJ+wqn0amYggYM+BV8a4+J9mmeOee2K63IOZgmyqrjXxF4I?=
 =?us-ascii?q?BhyU+M+C18SunH35YB3f6UxBeIVzD5jF25qMD4hZhEZS0OHmq40SXrH5RRab?=
 =?us-ascii?q?N0fYkWE2iuJde7ychki57iQX5X6lGjB1wd1c+mfBqddV393QlK2UsLpnynnD?=
 =?us-ascii?q?OyzyZonDExsqqfwCvOzvzgdBUdPG5LQmligEzjIYiziNAaU0yoYBYzmBS54k?=
 =?us-ascii?q?b6wrBRpL5jIGnLXUdIYy/2InlnUquyubqPY8pC5YgnsSVQV+S8blSaRaDnrx?=
 =?us-ascii?q?QG1CPjGnNUxConeDGyppX5gxt6hXqBI3ZztnrZeNpwxQve5NPGQ/5cxSEJRD?=
 =?us-ascii?q?NihjnKAFizIcOp8c+Vl5fEquq+TX6uVoVPcSn3yoONrC675Wx2DhCkgv+zm9?=
 =?us-ascii?q?LnEQk50S/8ytZmTyPIowjgYoPzzaS1LfpnflV0BF/788d6AJ9xkpUui5ELxX?=
 =?us-ascii?q?gXnYma/XodkWf0NNVb2L/+bH8XST4M2d7V7xDv2Fd/IXKR24L5SnKdz9NjZ9?=
 =?us-ascii?q?agfmwW2Sc94NpMCKiP97FLgSt1okC/rQLUYPh9gzIdxeEp6H4AjOEDoBAtwT?=
 =?us-ascii?q?mFArAOAUlYOjThlxeS4NCwtqpXZX2icbar20Zkgd+hC7SCqBlGWHnlYpciAT?=
 =?us-ascii?q?Nw7sJnPVLX133z7I7keN3RbdIOrRKUiQ3Pj/ZUKJI3mfoHniRnNnnnsXI5zO?=
 =?us-ascii?q?47iARk3Yums4ifN2Vt4KW5DwZYNz31fMMe4T/tgr1EksmK2ICvG41rGi8XU5?=
 =?us-ascii?q?vwUfKoDDUSuOz8NwmQCj08pWmUFKHfHQCF7Edmq3LOE5axO36LI3kZyM1oRA?=
 =?us-ascii?q?OBK0xHnAAUQDI6k4Y8Fg+2xMzubkd56SoK6VL/sRtD0OdoNwLiUmfZqwelcT?=
 =?us-ascii?q?Q0R4aFLBpQ8A5C413ZMcuE7uJ8BytY5IGurBSRKmyHYARFFXwGVVaaB1/9O7?=
 =?us-ascii?q?mj/sTP/PKGBuWgKvvOZbKOqeJCV/uSw5KgzJdm9S6WNsqTJnliE+E72k1bUH?=
 =?us-ascii?q?B2AcTWhToPSy8Xly/Wa86bpRG8+jB4r8Cx9/TrRQTv6paVBLtOMNVv/Ba2jb?=
 =?us-ascii?q?2EN+6KiyZzMSxY2Y8UxX/U1Lgf20YfiydvdzaxFrQAsTTCTLnKlq9ZEREbcT?=
 =?us-ascii?q?lzO9VT4qI53wlCJdTbitTp2b54j/41E01JWkDmmsGsfcYKOX2yNEvbBEaXM7?=
 =?us-ascii?q?SLPSbLzNz5Ya6nRr1Qi+JUtxK0uTmFCUPsIjODlzzxXRC1Le5MlD2bPABZuI?=
 =?us-ascii?q?ylaxZtFHbsTNT6ah26Nt97lzg2wboyhnPMK2EcLSNxc0VTob2M9yNYhfN/G2?=
 =?us-ascii?q?tE7nV7N+WLhyGZ7+zAIJYMrfRrGjh0l/5d4Hki0bta8SdES+ZulSvctdFiuU?=
 =?us-ascii?q?2pku6KyjB/ShpBti5LhJ6XvUVlIajZ9J5AVmjf8RMD92qQDQkFq8FjCtLxp6?=
 =?us-ascii?q?Bc0N7PlaPrIjdY793U5dccB9TTKM+fKHouKwfpGDrPAQsdVzGrKGXfi1VYkP?=
 =?us-ascii?q?GV8X2VtIY1poLwl5oJT78IHGAyQ9ETD0l+VPkFOo12RXtwk7ucltQJ/lK4pR?=
 =?us-ascii?q?zcRYNdpJ+RBdyIBvC6EyqUlblJYVMzxLr8KYkCftng11dKdkhxnIOMHVHZG9?=
 =?us-ascii?q?9KvHsyPUcPvExR/S0mHSUI0EX/Z1bouSJCGA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DxAwAQLRZe/wHyM5BmHQEBAQkBEQUFAYF8gX2BbSASh?=
 =?us-ascii?q?DOJA4ZeAQEBAQEBBoESJYlukUgJAQEBAQEBAQEBNwEBhEACgg44EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFCwgwgjspAYJ6AQUjFUEQCw4KAgImAgJXBg0IAQGCXz+CU?=
 =?us-ascii?q?yWsMIEyhU+DP4E9gQ4ojDN5gQeBEScMA4JdPodZgl4EkAmHFUaXQ4JAgkWTV?=
 =?us-ascii?q?wYbmmKrTiKBWCsIAhgIIQ+DKE8YDYEUmmIjA5ErAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 08 Jan 2020 19:33:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008JWT9g122499;
        Wed, 8 Jan 2020 14:32:29 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 14:33:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2001090551000.27794@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/8/20 1:58 PM, James Morris wrote:
> On Wed, 8 Jan 2020, Stephen Smalley wrote:
> 
>> This appears to impose a very different standard to this eBPF-based LSM than
>> has been applied to the existing LSMs, e.g. we are required to preserve
>> SELinux policy compatibility all the way back to Linux 2.6.0 such that new
>> kernel with old policy does not break userspace.  If that standard isn't being
>> applied to the eBPF-based LSM, it seems to inhibit its use in major Linux
>> distros, since otherwise users will in fact start experiencing breakage on the
>> first such incompatible change.  Not arguing for or against, just trying to
>> make sure I understand correctly...
> 
> A different standard would be applied here vs. a standard LSM like
> SELinux, which are retrofitted access control systems.
> 
> I see KRSI as being more of a debugging / analytical API, rather than an
> access control system. You could of course build such a system with KRSI
> but it would need to provide a layer of abstraction for general purpose
> users.
> 
> So yes this would be a special case, as its real value is in being a
> special case, i.e. dynamic security telemetry.

The cover letter subject line and the Kconfig help text refer to it as a 
BPF-based "MAC and Audit policy".  It has an enforce config option that 
enables the bpf programs to deny access, providing access control. IIRC, 
in the earlier discussion threads, the BPF maintainers suggested that 
Smack and other LSMs could be entirely re-implemented via it in the 
future, and that such an implementation would be more optimal.

Again, not arguing for or against, but wondering if people fully 
understand the implications.  If it ends up being useful, people will 
build access control systems with it, and it directly exposes a lot of 
kernel internals to userspace.  There was a lot of concern originally 
about the LSM hook interface becoming a stable ABI and/or about it being 
misused.  Exposing that interface along with every kernel data structure 
exposed through it to userspace seems like a major leap.  Even if the 
mainline kernel doesn't worry about any kind of stable interface 
guarantees for it, the distros might be forced to provide some kABI 
guarantees for it to appease ISVs and users...
