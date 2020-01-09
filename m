Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603C5136099
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgAIS6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 13:58:39 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:7387 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAIS6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 13:58:39 -0500
X-EEMSG-check-017: 42691197|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="42691197"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 18:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578596315; x=1610132315;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZPmZF83oIB329lW4as9cdr4MSFrWPuk7yQcwDUdxaTs=;
  b=ArJM0kfnQmQfIveCnEnGnxsVm0ApRvfR6Bfs+PTei5RwobTwdfDVcbjL
   kw9U1xSY3iFWsQVsYzVVG2KnzuIq/Tszv3Celfr3JpY7b9x9OV0GFSxob
   wyWjQbQ3bd7JYN4EBjishM66J/j2Y5U/dvqc85cAzMBoU4Io4DQSbGsvT
   Ldv6lUEF7fuIa7LwXs7IbUql33d6ppuY5Zti/Dha3lh7760uT1jpWVhTd
   90HoLqibmPCnRO8iIaMJpz4G1ilYZG4UnFArJPkjcd4AvIhSIFl/ZidE+
   J7WJe/P9UZ+2AP2HV2/i/HT6aB11p0hHhpGyM+UDEXzuWVYrC/IZo6IUe
   w==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="31783925"
IronPort-PHdr: =?us-ascii?q?9a23=3ApTpPtBcddllUzr+Pmi3P4rINlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc6/ZhON2/xhgRfzUJnB7Loc0qyK6vumAzJZqsbY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgJZuJqkyxx?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAmoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MCLEBJfXzWlXrtNzZFR80KAq0zPziCNpj14MSQ2WPAr?=
 =?us-ascii?q?WWMKnKq1+H+vovI/WQZI8SoDv9KOYq6OD1jXAlnl8deqqp0IALZ3C4BPRmJE?=
 =?us-ascii?q?CZYXvxgtcEC2sKuRA+TOPygl2YTTFTf2qyX7475jwjC4KmFZzDRoGrgLyO3C?=
 =?us-ascii?q?e2BYFZZmBcClCLFHfodpiEW/IWZCKVOM9hnSQOVaK9RI85yRGuqAj6xqJ7Ie?=
 =?us-ascii?q?XO4S0Xq5Li2cNu5+LPlRE97yF0D8qZ026TVWF4h38HSCUs0K9jpkx9z0+J0b?=
 =?us-ascii?q?JkjPxACdxT+/RJXx8+NZ7dyex6Ft/zVhvCftiXUlamRMupATUqQ9IvzN8BfV?=
 =?us-ascii?q?x9F8+hjh/dxSqqBaEal7iRCJwz6KLc0GD7J9xhxHbeyKkhk14mT9NUOm2+iK?=
 =?us-ascii?q?5y7BbTB4HXnEWDjaqqdroT3DTL9GidyWqCpkZYUBR/Ua/dR3AQelPWrcjl5k?=
 =?us-ascii?q?PFV7KuDbUnMg1cyc+NM6dKccPmgklbRPf5OdTef2Kwl361BRaP27yMcY7qdH?=
 =?us-ascii?q?sG0SXDB0gLjRoT8WyFNQcgHCehpXzRDDh0GVLoeUPs/vF0qGmnQU8s0wGKc0?=
 =?us-ascii?q?ph2qKv9R4OmfyRUPAT0aweuCcntTp0GEyx39XMC9qPvwBhZrlTYcsh4Fdb0m?=
 =?us-ascii?q?LUrxFyMYamL6BjmFEedx96v0Lp1xV4FIpPi9Iqo2gtzAt9M66Y1k1Ody+A15?=
 =?us-ascii?q?DqJrLXMnXy/Ayoa6POxlHe0NmW9b0V6PQ+qlXsohqkGVYi83V91NlV1nqc5o?=
 =?us-ascii?q?jPDAYIVpLxSEk3/QBgp77Geik9+5/U1Xp0PKmxsj/NwdYpC/c/yhancdZSK6?=
 =?us-ascii?q?yEFAj1E80VA8ihNvYmlESubhIBJOpS7rI7P9u6d/ua366mJP5gnDC6jWlc74?=
 =?us-ascii?q?B91UWM9yV4SuHWxZoK3/aY3g6fXTfmkFihqtz3mZxDZTwKBWW/0zbrBIhMaa?=
 =?us-ascii?q?Joe4YHE3qhL9e4xtVkmZHtVHFY+UWsB1MDwsCpeB6SY0bh0g1X0EQduWanlj?=
 =?us-ascii?q?egzzxojzEpqbKS3C7UzOTkchoHOnVGRGZljVfrLoi0i84VUFK0YAgukRuv/V?=
 =?us-ascii?q?z6yLRDpKRjM2nTRl9Ffy30L2FtUqa9sqGPY8FI6JMvviVXVPqzbUqGRb76ph?=
 =?us-ascii?q?sQyznjEHdGxDAnazGqvY30kAB6iGKHLXZzt2bZecBqyhfZ/9HTXuRR0SAbRC?=
 =?us-ascii?q?l+lzbXHEKwP9iu/d+MjZfMrvi+V369Vp1UaSTryIKAuzeg6GJ3AB2/kPGzmt?=
 =?us-ascii?q?7gEQcnyyP70cdlVTnQphbmfobrz7i6Mf5gfkRwHl/z9dR6FZ9lkossn5wfxX?=
 =?us-ascii?q?gaho+S/XoCkGfzLNBb1bj5bHoXSj4B28TV7xT92E1/MnKJwJr0VneHzcR9ZN?=
 =?us-ascii?q?m6Z3kZ2iQm4M1RFKiU7KZEnSxwolq5sALRZOJxnjAHyfsh8HQamf0GuBIxzi?=
 =?us-ascii?q?WBBbAfBUpYMjbilxuS7tCzt6tXa321fbes00p+mMirDKuerQFERHb5ZpAiED?=
 =?us-ascii?q?dr7sV4NlLM33nz6oD5eNbLd9IcrAOUkxbGj+haM58xmOEFiTB7NmL6uH0v0/?=
 =?us-ascii?q?Q7ggB23ZGmoIiHLH1g/aK5Ah5DLTD1adgc9ivxgqZZm8acx5qvEYl5GjUXQJ?=
 =?us-ascii?q?voSuqlECkMuvT9OAaBDiYxqneBFrrbGQ+e6EFmo2jTHJCsMnGdPGMZwsl6RB?=
 =?us-ascii?q?mBOExfhxgZXDAmkZ45CA+qxNbuf1x+6jAK/FH4rwBMyv9uNxnwSWrfpxmnai?=
 =?us-ascii?q?0ySJeBKBpa9AZC513aMcaG9OJ8AzlY/oG9rAyKMmGUeh5HDX8XVUyBHF3sI6?=
 =?us-ascii?q?Oh5cfe/OidAuq+KPXOYamUpexYSfiI2Yql0pF68DaUKsWPIn5iAuU02kpZQ3?=
 =?us-ascii?q?95FMfZmzUURiwTliLNadObpRiy+i1ws8C/9unkVxjz5YuODLtSN89j+xesga?=
 =?us-ascii?q?eML+SQnjp2KS5E1pMQwn/F0L4f3F8OhCFpczmiC68AuTTDTK3OgK9XFQAUZj?=
 =?us-ascii?q?h2NMtJ8608xA5NNtLbitP0zr50lOI6C1BAVVb5gMGmedQKI32hNFPAHEuLL6?=
 =?us-ascii?q?mJJTPQzsH4ZqO8TrJQjOFKuBGqpTmbFErjNCyZlzb1TxCvLf1MjCaDMRxHpY?=
 =?us-ascii?q?GybBBtCXTiTNLgcBG7Ndh3jTswwbIqmnPHLmgcPiZgc0NXqb2Q6yRYgvBhFG?=
 =?us-ascii?q?Bb8nVlKuyEkT6D7+bEMpYWredrAiNsmuJA/Xs6zaFa4TpKRPNugifdstluo1?=
 =?us-ascii?q?S+mOmV1jVnSAZOqipMhI+Tv0ViPrvW+4JOWHne+hIC8H+cCxIUqNt5ENHvva?=
 =?us-ascii?q?FRwMDVlK3vMDdC787U/cwECsjMMs2HLX4hPAHxGDHOEQsFSSenNWTYh0xaiv?=
 =?us-ascii?q?Gd6GeZoYQ9qpjpy9IyTep5XVk4Dbs/DV5/HcdKdJVyWSk+kKWziscN6Hv4qw?=
 =?us-ascii?q?PeEpZ0pJfCA8mODO3vJTDRtrxNYx8F0PusNogIHpHq0ExlLF9hlcLFHFSGDo?=
 =?us-ascii?q?MFmTFocgJh+BYFy3N5VGBmnhu4Ow4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DWBACbdhde/wHyM5BlHQEBAQkBEQUFAYF7gX2BbAEgE?=
 =?us-ascii?q?oQziQOGYQEBAQEBAQaBN4lukUgJAQEBAQEBAQEBNwEBhEACghM4EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFCwgwgjspAYJ5AQEBAQIBIxVBBQsLDgoCAiYCAlcGDQgBA?=
 =?us-ascii?q?YJjP4JXBSCqfnWBMoVJgz6BPYEOKIlQgmN5gQeBEScPgl0+h1mCXgSNT4I7h?=
 =?us-ascii?q?xVGl0eCQIJFk1wGG4JHjEGLXKtVIoFYKwgCGAghD4MoTxgNgRSaYiMDkUUBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2020 18:58:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009IvkX8259016;
        Thu, 9 Jan 2020 13:57:48 -0500
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
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 13:58:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2001100437550.21515@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/20 1:11 PM, James Morris wrote:
> On Wed, 8 Jan 2020, Stephen Smalley wrote:
> 
>> The cover letter subject line and the Kconfig help text refer to it as a
>> BPF-based "MAC and Audit policy".  It has an enforce config option that
>> enables the bpf programs to deny access, providing access control. IIRC, in
>> the earlier discussion threads, the BPF maintainers suggested that Smack and
>> other LSMs could be entirely re-implemented via it in the future, and that
>> such an implementation would be more optimal.
> 
> In this case, the eBPF code is similar to a kernel module, rather than a
> loadable policy file.  It's a loadable mechanism, rather than a policy, in
> my view.

I thought you frowned on dynamically loadable LSMs for both security and 
correctness reasons? And a traditional security module would necessarily 
fall under GPL; is the eBPF code required to be likewise?  If not, KRSI 
is a gateway for proprietary LSMs...

> This would be similar to the difference between iptables rules and
> loadable eBPF networking code.  I'd be interested to know how the
> eBPF networking scenarios are handled wrt kernel ABI.
> 
> 
>> Again, not arguing for or against, but wondering if people fully understand
>> the implications.  If it ends up being useful, people will build access
>> control systems with it, and it directly exposes a lot of kernel internals to
>> userspace.  There was a lot of concern originally about the LSM hook interface
>> becoming a stable ABI and/or about it being misused.  Exposing that interface
>> along with every kernel data structure exposed through it to userspace seems
>> like a major leap.
> 
> Agreed this is a leap, although I'm not sure I'd characterize it as
> exposure to userspace -- it allows dynamic extension of the LSM API from
> userland, but the code is executed in the kernel.
> 
> KP: One thing I'd like to understand better is the attack surface
> introduced by this.  IIUC, the BTF fields are read only, so the eBPF code
> should not be able to modify any LSM parameters, correct?
> 
> 
>>   Even if the mainline kernel doesn't worry about any kind
>> of stable interface guarantees for it, the distros might be forced to provide
>> some kABI guarantees for it to appease ISVs and users...
> 
> How is this handled currently for other eBPF use-cases?
> 

