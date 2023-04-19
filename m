Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A016E77CE
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjDSKyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjDSKyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 06:54:24 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE4DE12CA4;
        Wed, 19 Apr 2023 03:54:11 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 33JArQ9R010864;
        Wed, 19 Apr 2023 05:53:26 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 33JArO2V010863;
        Wed, 19 Apr 2023 05:53:24 -0500
Date:   Wed, 19 Apr 2023 05:53:24 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Message-ID: <20230419105324.GA10725@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com> <6436eea2.170a0220.97ead.52a8@mx.google.com> <20230414202345.GA3971@wind.enjellic.com> <CAEf4BzZQ8EYNe_oGDEoc0_a3k8C2CYe2F6scBD2Xj2MZ9TE7ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZQ8EYNe_oGDEoc0_a3k8C2CYe2F6scBD2Xj2MZ9TE7ug@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 19 Apr 2023 05:53:26 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 04:31:31PM -0700, Andrii Nakryiko wrote:

Hi, I hope the week is going well for everyone.

> On Fri, Apr 14, 2023 at 1:24???PM Dr. Greg <greg@enjellic.com> wrote:
> >
> > On Wed, Apr 12, 2023 at 10:47:13AM -0700, Kees Cook wrote:
> >
> > Hi, I hope the week is ending well for everyone.
> >
> > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > On Wed, Apr 12, 2023 at 12:33???AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > >
> > > > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
> > > > > are meant to allow highly-granular LSM-based control over the usage of BPF
> > > > > subsytem. Specifically, to control the creation of BPF maps and BTF data
> > > > > objects, which are fundamental building blocks of any modern BPF application.
> > > > >
> > > > > These new hooks are able to override default kernel-side CAP_BPF-based (and
> > > > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> > > > > implement LSM policies that could granularly enforce more restrictions on
> > > > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
> > > > > cases.
> > > >
> > > > One of the hallmarks of the LSM has always been that it is
> > > > non-authoritative: it cannot unilaterally grant access, it can only
> > > > restrict what would have been otherwise permitted on a traditional
> > > > Linux system.  Put another way, a LSM should not undermine the Linux
> > > > discretionary access controls, e.g. capabilities.
> > > >
> > > > If there is a problem with the eBPF capability-based access controls,
> > > > that problem needs to be addressed in how the core eBPF code
> > > > implements its capability checks, not by modifying the LSM mechanism
> > > > to bypass these checks.
> >
> > > I think semantics matter here. I wouldn't view this as _bypassing_
> > > capability enforcement: it's just more fine-grained access control.
> > >
> > > For example, in many places we have things like:
> > >
> > >       if (!some_check(...) && !capable(...))
> > >               return -EPERM;
> > >
> > > I would expect this is a similar logic. An operation can succeed if the
> > > access control requirement is met. The mismatch we have through-out the
> > > kernel is that capability checks aren't strictly done by LSM hooks. And
> > > this series conceptually, I think, doesn't violate that -- it's changing
> > > the logic of the capability checks, not the LSM (i.e. there no LSM hooks
> > > yet here).
> > >
> > > The reason CAP_BPF was created was because there was nothing else that
> > > would be fine-grained enough at the time.

> > This was one of the issues, among others, that the TSEM LSM we are
> > working to upstream, was designed to address and may be an avenue
> > forward.
> >
> > TSEM, being narratival rather than deontologically based, provides a
> > framework for security permissions that are based on a
> > characterization of the event itself.  So the permissions are as
> > variable as the contents of whatever BPF related information is passed
> > to the bpf* LSM hooks [1].
> >
> > Currently, the tsem_bpf_* hooks are generically modeled.  We would
> > certainly entertain any discussion or suggestions as to what elements
> > of the structures passed to the hooks would be useful with respect
> > to establishing security policies useful and appropriate to the BPF
> > community.

> Could you please provide some links to get a bit more context and
> information? I'd like to understand at least "narratival rather than
> deontologically based" part of this.

We don't have much in the way of links, hopefully some simple prose
will be helpful.

'Narratival vs deontological' contrasts the logic philosophy that is
being used in the design of a security architecture.

Deontological implies that the security architecture is 'rules' based.
A concept embraced by the classic mandatory access control
architectures such as SeLinux.

Narratival, the logic predicate embraced by TSEM, implies that the
security architecture is events based and is constructed from a
narration of a known good workload by unit testing.

At the risk of indulging in further philosophical wonkiness, the two
bodies of logic arise from the constrasting philosopies espoused by
Immanual Kant and Georg Wilhelm Friedrich Hegel.  It is somewhat less
precise, but a security architecture that is rules based would be
considered 'Kantian' motivated while an events based architecture
would be considered 'Hegelian' inspired.

So, departing from epistemology, what does all of this mean with
respect to security.

In a policy based architecture, the security decision is a product of
the rules, in the case of SeLinux a rather complex corpus, that have
been established to regulate the interaction of a role, subject and
object label.

In an events based architecture, the security decision is a product of
the characteristics of the event.  From a granularity perspective,
which seems to be an issue in this BPF/BTF discussion, the granularity
of the security decision can be as variable as any of characteristics
that is used to describe the LSM event at the operating system level.

In TSEM, the characteristics of the event are used to generic a unique
numeric coefficient specific to the event.  The TSEM documentation
discusses the functional generation of these coefficients.

In the case of the three bpf LSM hooks that are in 6.5, this would be
any of the characteristics embodied in the following variables.

bpf command
bpf_attributes
bpf_map
fmode_t
bpf_prog

With respect to your problem at hand; Paul Moore suggested elsewhere
in this thread that there were smart people hanging around on the list
that might be able to comment on the challenge of CAP_BPF lacking
granularity and being unavailable in a user namespace.

I can't claim to being very smart, but I did hook up the big screen TV
at our lake place in west-central Minnesota and it worked the first
time, so here goes some thoughts.

I can't claim a great deal of experience with BPF, but I'm assuming
that any of the characteristics above, or that would be passed to the
proposed BPF LSM hooks, would embody sufficient information about a
BPF program to fully characterize it from a security perspective.

I'm also assuming that the BPF implementation in the Linux kernel is
now sufficiently featureful for a BPF program to assist in making a
security decision by analyzing any of the attributes passed to an LSM
hook for a subsequent and subordinate BPF program.

We currently don't have support in TSEM for connecting a BPF program
to an in kernel Trusted Modeling Agent (TMA), but it is on our radar
screen, desperately seeking attention cycles.  With such hypothetical
support in place, I would propose gating the ability to attach a BPF
program to a TMA with CAP_BPF.  Said program would then assume the
role of assisting the TMA in generating the security coefficients for
subsequent BPF related security events in the modeling namespace.

At that point, the security behavior of subsequent BPF programs will
be under the control of the security model being run by the TMA
assigned to that security namespace.  It can be as granular and
restrictive as any security characteristics that would be described as
being relevant to BPF.

From a security perspective, you don't write any security policy, you
unit test the BPF application and the trust orchestrator generates the
security model that would be subsequently enforced.

With this model, you don't override any existing security controls and
the LSM implementation remains purely restrictive.  CAP_BPF regulates
whether the BPF infrastructure can be accessed and BPF itself becomes
responsible for defining the permissable security behavior of any
subordinate BPF applications.

There are undoubtedly considerations needed in the BPF implementation
to support this model but I haven't had time to look at those
particulars.

There is further discussion of the concepts involved in the 18+ page
documentation file that was included in the V0 release of TSEM.  Here
is the lore link for the original series:

https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/#t

The V1 release, currently being finalized, is a significantly enhanced
implementation but the architectural and security concepts discussed
are all still relevant, if there is a desire to dig into this further.

With respect to the thinking and writings of Kant and Hegel, Wikipedia
is your friend.... :-)

To conclude in a big picture context, if it hasn't already jumped out
at people.  While TSEM operates practically from a narratival design
perspective, it is designed to do so by applying either deterministic
or machine learning models to the characterization and enforcement of
the security behavior of a platform.

The reason we have a somewhat intense interest in BPF is that HIDS
based machine learning models need to do characteristic screening in
order to be properly trained for anomaly detection.  BPF is a pathway
to achieving this with a single kernel based trusted modeling agent
implementation.

Now, back to figuring out how to hook up the stereo/hifi.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
