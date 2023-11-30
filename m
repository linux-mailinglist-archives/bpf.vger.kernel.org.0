Return-Path: <bpf+bounces-16226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF957FE8A8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5611C20BCE
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF561549F;
	Thu, 30 Nov 2023 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rrYzNICl"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597431FC2
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:23:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSjjaae+kKwx3t3V7103dRTywG7qJoKDkkpTCSyrlOuRYQ32oz+DTig2HwIAhtfQGJM4yy7kbcvj3Nt51lleWX4b5qpPCDtkRq4E+ScFC3DjCceaNSIxQVKjdBspgJv9MIw24XFKMKdOWhyr7vxDpI0k2QsUd0hg/gRy4h/dXp3dgWzz0I4H9BAB7GvFxpuXBbMvBfTHS74s/0c/idxXUGzVke2dQeKj/YmDf/2syZcRXJ4gmc+Dwwgyx9vd7uY/SQ9uteW5wiQYpaDQ/nbpU7q16MWPc6gbEwknZUYTHYhpLG3g88kpXXcwPk+gH5295aM7g0gS0GP/iqsrzrS2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dH3wSjw77hfoy05j7hfVKe+6XY4LgDsnzL2KAtz48Y=;
 b=VmAtQyiLJOjnLvnq31/AMpVMwFh91ahrkJFaPdBzM2G6ad+wiXXDkDTgFLiOLMphl9IOSwfUY12MJweOHpPfWGkP5jbQAohQuNHq2NqgHTnuPHmfPPNhYJ/OIgvMsY6JAu5PAmqP5Oc/5tUMcJNSbtDSXRk0Sn1ins6TQinuhEyy7SQlkqr+JahCgq9ZHpzdElgFCQ9YrvjlA7UlUO6pILH+JxUq0GS1NTfnvzWbg0S/jsoHaDXjcHNTRolOhQZpzbnG0QwuDlH16jb4+0robj594YKxFCPShrFyUelqd7YnYOb8muS8w0QAi66qwDrNgdWh6RCUA/ruH8pBxIZpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dH3wSjw77hfoy05j7hfVKe+6XY4LgDsnzL2KAtz48Y=;
 b=rrYzNICl27my4IsHT5iSN9DBbEHQzWY3YlZXUogIbZrkoCIXu5Ny4kU+DZtfdFM/wFwrA4psHjNmyzC/uhij3m8vjb3ndA6N6Iqzf//nzg+hOOfCjun7JGo2/N4NKf4FQ6OC+Ww7StMN0e03HWQ66YKgtJ8LQR3fhpX20+MujTCa4MBCfNXxZIv/7GRV7fBUzaH+UB9wPZy4G93ciYyj1sWIN1Qz0BKjr2KLj9TFgy3oQh72gV+MIB4T2kQQdLbvnPUSrJ8ED1xtvZ10JPTGIuOGJk6MIGMVPgGc1H/st7BlO0lPLJGl0eXkylTHLCB7+l3siCMJDzG9B7AmEcwWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:23:49 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:23:49 +0000
Date: Thu, 30 Nov 2023 13:23:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
Message-ID: <ZWgcW2RCDW9hoOVI@u94a>
References: <20231129003620.1049610-1-andrii@kernel.org>
 <20231129003620.1049610-4-andrii@kernel.org>
 <carufygwn5mf27v5y336tout32yokzoqhfaot2skxgn7s54rxb@qp3qicqilpcz>
 <CAEf4BzbUjsW0JfMwZQQYETafs=6yD=cs23W_PJ6=H90YMZudyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbUjsW0JfMwZQQYETafs=6yD=cs23W_PJ6=H90YMZudyQ@mail.gmail.com>
X-ClientProxiedBy: TYAPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::20) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 57acb509-6d0e-4c1d-7b7f-08dbf1648850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqDb1O2ungFn6OvPevQMJhLF49cGIzFlmxgNRQsfuV6fuPZMepQRid7pzwHrkHkn37ggVSG/sfUSGHKrBSQZzif0GXfA+NxHw1O7Ybq9o+hrVo3DfiobESxYQ/+aMaRZL+REEwdTjy6hs3uWEBmUDFBU4o9m5CTf5o9bw9RUcEVNr+X7DLsG66fJj/UR7DyEwyMabquCEhi27MQCC9l30Vl5tpT9sf6oqBLQbGnzMXn+PvFfdWAlatBDwz8MgJ5Ead8UmBd/C2pUT5NNPUrjXkfErfd5o0/p96CcMLB9Xnyu7GEjFO5bCOPTIx4l13eBtH8aLdx/y11b0M4Srk2vJsLe5BAwnbSf8sqi7Z9GWmd00BBQtQPF1aLfM2WTqCj2RkTVW6CsIQABCGLawd/+D2UreAJ6wULjAmbiBuqhrIZ3iCy8DKiuDDptfzASk7uc/kyM+eCpz/I5yjbqwiwRjEiaH/0Z2rdk8XmWcr4XWdYSTgTn864JHfeAVEx4MIVezLQghERBygvXs9fKkz49i/a6BYHzYk1MsEA2wJ8jYKo8dhmp0JRQEmG9uMzJc6e3EJ9etw5kNrrM6sJ9qmeDAESlbjTCFJyZ6GASVcqZu4q7Is9uqJaLs2fHaKwo9Ke7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(33716001)(41300700001)(38100700002)(6666004)(6512007)(6486002)(86362001)(9686003)(26005)(53546011)(6506007)(478600001)(83380400001)(66556008)(316002)(54906003)(6916009)(66946007)(4326008)(8676002)(202311291699003)(8936002)(66476007)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1dvNUIzZk5jWlJoMzlSWUpxM1JNWVlLa0ROVis0WDY4V1hyTXRwOEZDeFps?=
 =?utf-8?B?ZGdSN0lVa09nb1ptQWMvT2RpN21pbEZZQ1JQcWtDdlBXNG5XcEJjTmpsNGNH?=
 =?utf-8?B?Y1Zib2VqaFBmZ1h3T1dyeGxTcnZmOURjRDhzQ1FNSnNzT3lWQk9pYVlObnNH?=
 =?utf-8?B?SDB5VjY2eUJTZEdNdlkzazhHajBvalJyaTBiYzRPclMrYXRJZjkwckJDZVFi?=
 =?utf-8?B?S1piNXdlY0Y4RDlyVXRZQUtMK2dVazVOYnFpMTF3RmlMZEJtMzNrdzRjSVV4?=
 =?utf-8?B?OXBobjJPbnlhZTVOOXBISzhUUzVWUUVKWmFveGJZYjBRZVVQa1JTblphSUdt?=
 =?utf-8?B?b1o1cXZRalRUWlpwVGN1enhBVHFweXdqeldzOEEzK21nM3lzaDlvdnBwNWNw?=
 =?utf-8?B?aEdQYXNsbEh3V1N0ZStHT01OZWwxVHVhNFgwbDdiaGFIMk1hSVRIK2wzcGFa?=
 =?utf-8?B?a0ZJajBKM3VSZGVISkxxdGwrNERuQmw1ZVg1TW0vcHkwczNNMDQxeGl1ZkFU?=
 =?utf-8?B?ZVhMSjYrSFFTTVIrdEtWSlZvNlRIY1FXRjdiK05TYitkM2ZzRzNYK3pEQi9V?=
 =?utf-8?B?NGdqT2N0WkNiUjh1WWgwajhwSlZGSE82eE1BQzUzU3NzM2d1RVVQSFUxcG5w?=
 =?utf-8?B?TWhCVmZvcEUwZkEza2RmUEgzM01oTCtlc0o1TUVOb2g0VEhMQkxoS1d5Q2JW?=
 =?utf-8?B?OWxSU0FsaEd3dlRCWWIzcEZQOGxYdW9ML3ZpUHk0aVFSa05LS2JiMlFzVG9h?=
 =?utf-8?B?ckVNV0lWQWVrUDBTNnY4SktkMDJzRllPVDZLK0FqRFc3MlBqMkpNU203OXpE?=
 =?utf-8?B?OS95UFB4MHROUU5XSk8vN1N0SVBWWDV5VUpUMEhydStEYy9VS3NidnlVTmor?=
 =?utf-8?B?OCtoMnc2S2Jqc2VjNE4vU1YvUGxUODlJWHFFeHV6bWZDRVV0Wi8vUkdxdWVM?=
 =?utf-8?B?VUtYTkczdS9xZ3p1SnBtYWpHMDJiQ1hudERMUTJDODRKY1Roc0lHZzd6WWVr?=
 =?utf-8?B?TS8vSzZubXZIdGY4dGprUmdRdXhHSWlDV0xJVGxVRlJJMWRENS8reW1jSFVT?=
 =?utf-8?B?anpVZ3BRL0VqeU1seFFxR1FpMFkrYzhIbmFRcW5VQzFhZndpNEpnM0NTZmxC?=
 =?utf-8?B?K2E0RVNwcFpZWVlnYnk4OW5GYlRxcW9PajZITVhCYzdkeVpFRGc1NjU0NDlw?=
 =?utf-8?B?M1VrQmF6VTZqek5ySWErcFhFS0lrNU44b0R2U3ZqVzZVOEdHTEFLZFBMc1pl?=
 =?utf-8?B?RERzWE5keHJGTzhMVXJVL053dUlHTFNrcXozU3JFV3BrRUp5YWZZOEs5RjBy?=
 =?utf-8?B?c0VaV0hxeDQ3UFl2UWtUR3BoeGx2YkZQaFZTbWFhSTVJeU1MZktvOXhYZkFo?=
 =?utf-8?B?M3lGUlJDNEd5UUNxZS9qamh1ME5ZK2kvNjJGZW1lNXFYaTV0bU1qNENJN0dC?=
 =?utf-8?B?N29GcmkrODBaZGo1VzZKeHpnS1A0cHJhVXl0alBtOHdjWVpmekJ1cW5VVHho?=
 =?utf-8?B?dVMzdjJvR0d3NVhtbjB5ZVpIUjczb1FOTkRZNjFETmNSeWl5U05XdytFUnZ2?=
 =?utf-8?B?RVh4QjIzckdFaUhMVDB5VUpKV1pmYUxad0p3VTZNRUNLa2VGSi92RzJ2dmlj?=
 =?utf-8?B?Ti9Da3BYWTZMVTBzdkkvQ2QyZFhZeHNzaGdRbmFacEVYbW5GZTFKcU9PUEVj?=
 =?utf-8?B?NS92MjdKYmwvV2hYWURUaXNaR0RFQWJtNVR1T3Q4cmFTMzZwZ25nUHZRTTlF?=
 =?utf-8?B?dnU0QzJKVTVCdkNkUENUUERjWHNYTEpLQlJqT1FVd0pVN3RHeExGak9Yekcw?=
 =?utf-8?B?SDQrTTg0T0plVzBKNGdhbkdydXRvV0l3VHVDOUpRQ3R2QnNJUTljbCs4RzBN?=
 =?utf-8?B?Ti9LS1JDMnc0REEyVExBOGdGQU5LclFLY2lNUEpuN0xocWR6aHB5Yk9LaHlJ?=
 =?utf-8?B?WFlXZjdEVC94YWlyZG4vTHZPdDRLQVc1dUw1TEtvL0phL1RLd1ZiMkNPVGtB?=
 =?utf-8?B?aFQ3RndsbDU3LzVIbjEwRkZoNjBFVUtuNjhScS9GNGxIZ2dpRG1EQ05yYWVS?=
 =?utf-8?B?dXVzQkJtUVl3QnhRZ0NSd2Znc3JrMlNhY0ZsZU4xRzNaL0orZDZhNGhsYkp0?=
 =?utf-8?B?dzQ3NDc3dVQrNmFCUjN1NXRIeDk5Zkx4MVJyeDJzQ0FZUkhCYnFwNE5pcDNK?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57acb509-6d0e-4c1d-7b7f-08dbf1648850
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:23:49.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rt4U04uQsneYEuNeRi3+4xl6VZekuUN+qv6STncuFDOCTAi5sYpIsaUlERSzGherpvXa+cSkMz97YcTqdMEGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678

On Wed, Nov 29, 2023 at 08:23:38AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 29, 2023 at 2:56 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Tue, Nov 28, 2023 at 04:36:13PM -0800, Andrii Nakryiko wrote:
> > > Instead of relying on potentially imprecise tnum representation of
> > > expected return value range for callbacks and subprogs, validate that
> > > umin/umax range satisfy exact expected range of return values.
> > >
> > > E.g., if callback would need to return [0, 2] range, tnum can't
> > > represent this precisely and instead will allow [0, 3] range. By
> > > checking umin/umax range, we can make sure that subprog/callback indeed
> > > returns only valid [0, 2] range.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf_verifier.h |  7 ++++++-
> > >  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
> > >  2 files changed, 35 insertions(+), 12 deletions(-)
> >
> > ...
> >
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
> > >       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> > >  }
> > >
> > > +static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
> > > +{
> > > +     return range.minval <= reg->umin_value && reg->umax_value <= range.maxval;
> > > +}
> > > +
> > > +static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
> > > +{
> > > +     if (range.minval == range.maxval)
> > > +             return tnum_const(range.minval);
> > > +     else
> > > +             return tnum_range(range.minval, range.maxval);
> > > +}
> >
> > Nit: find it slightly strange to have retval_range_as_tnum() added here
> > (patch 3), only to be removed again in the patch 5. As far as I can see
> > patch 4 doesn't require this, and it is only used once.
> >
> > Perhaps just replace its use below with tnum_range() instead? (Not
> > pretty, but will be removed anyway).
> 
> I do this to delay the refactoring of verbose_invalid_scalar() which
> is used by another piece of logic which I refactor in a separate
> patch. If I don't do this temporary retval_range_as_tnum() helper, I
> might need to update some more tests that expect exact var_off value
> in logs, and I didn't want to do it. Given it's a trivial helper, it
> feels like it's not a big deal to keep it for a patch or two before
> completing the refactoring.

Replace retval_range_as_tnum(callee->callback_ret_range) with 

  tnum_range(callee->callback_ret_range.minval,
             callee->callback_ret_range.maxval)

and the verbose_invalid_scalar() signature stays the same; also no var_off
changes because it is just manual inline of retval_range_as_tnum(), as
tnum_range(n, n) == tnum_const(n).

Agree it really is not a big deal, so I won't insist on it.

> > > @@ -9597,7 +9612,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
> > >               if (err)
> > >                       return err;
> > >
> > > -             if (!tnum_in(range, r0->var_off)) {
> > > +             /* enforce R0 return value range */
> > > +             if (!retval_range_within(callee->callback_ret_range, r0)) {
> > > +                     struct tnum range = retval_range_as_tnum(callee->callback_ret_range);

