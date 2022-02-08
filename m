Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1162B4AD0F4
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiBHFdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbiBHExy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 23:53:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2092.outbound.protection.outlook.com [40.107.93.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9978C0401DC
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 20:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gay77G00MtpeFM5GZtL0OJek0TLmyen2NL5Ra7hDkUtUC3mBWxT2o9Aqa4kbjzDTxDNPL4EhmNswU3Y/oDTAooz7c0ETCIjOHxw3ppPvDbyVrREuzeWal5EqoOrS6OzPhG+BDG0rP4CD5Bpu7476Wsr68bgDIi/CglaF0eaCvgi5UMfXNjZioBRlOzAWVoW6RCt1Qru1iAxEZ3ubZ6K5ub4VhzjB46eSD/mNr8PtIaeQQlcatcglGhcYTUW4E/88BvcUXyvsA7zFUR9Rpsbd56t3yS9PnACIkRd6HmAScSlUb69w+Y5rMQECajGwllR+wkgff1PqpFboPpvmVZKKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZrZNSPmr6EBIONlNB4xwaEx2A3w7vz6AkXmlrc37SQ=;
 b=ZdiEwxN9yIbRFu+RIo5VG2V6RBtAaJOVDBx8ONHMFGIrMsnvnH59D4d4XVtdNKKWN/UKgvM9QjeLHYTWIeK4gUC80N3g/SU3QPJTF5EYR37t4QnSF3MRJlfl86lOzYLmoLkuHN6Rplns37QTY6MWBUhBQSrSHn6meuBtS9pO2BJm6KyoZvrWirq5zVpxZKObL5GUv0XZmBuuZfzdJyPEymapJuwd1vSZO3+rBU88FbEElr6pWTOuv6xSKaHbmVkXMS/zO/SZQGuOdTaQgOmCXOJP98vENfnx6fP54ci/UdOeUfGD8B7buBIgE+QzdyTB4c6TBSKAeoWyr2qKw5HFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZrZNSPmr6EBIONlNB4xwaEx2A3w7vz6AkXmlrc37SQ=;
 b=tWvNxgqvN08jQg3+AkzuUTPXpU0hjlRAd/T14V8ikH9mKsBZV4QaIYYD/Y+beKQhZ9jgXYFpqQ6eOiSUuFpasJU2rMCNLHFacLhoppZJVK48doiO+CaOeYrcGMYgthdwC9EVw4bg5L4p+hVuwGX/MyrAw7KCQPWqc/Td0gkcIkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by SJ0PR13MB5335.namprd13.prod.outlook.com (2603:10b6:a03:3e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.9; Tue, 8 Feb
 2022 04:53:49 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::969:8e09:d5ca:8a86]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::969:8e09:d5ca:8a86%4]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 04:53:49 +0000
Date:   Tue, 8 Feb 2022 12:53:43 +0800
From:   Yinjun Zhang <yinjun.zhang@corigine.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, niklas.soderlund@corigine.com,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Message-ID: <20220208045343.GA16157@nj-rack01-04.nji.corigine.com>
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
 <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
 <YgFdgOVdEWUx63Ik@krava>
 <YgFkVXggmihEpO/o@krava>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgFkVXggmihEpO/o@krava>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To DM6PR13MB3705.namprd13.prod.outlook.com
 (2603:10b6:5:24c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea80c6ee-efa3-4b64-3e52-08d9eabeff20
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5335:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR13MB5335EFE607D77CEDE5A5968CFC2D9@SJ0PR13MB5335.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl6PVcch+1lvYOajb5wiV/JJIgP+Vsq76rpmQmQ18l+o6nX71tavyPVAoBP5MCFJTJWWFdR6L4iG0wYwlIgOTYjGn7ffOeKsWxPI8ND+gS33ijTE8H5Cd17QH1Lb9TCWRZjYhJGSzBWJ4vC0jCVRiZHNG7igk2lG66XuPI7dTZGf1fBTsFGGjr4EVpMZGMaODziKxma2V4STCWsOJl86ujifFLPpSLZNeUjSZe52DayEAfzb3xXv1hsaF/33nSWJvTE9wGJHLcFvSQuHRbor1IuJRxNIguXMy3M9hwC5zYnTBclNkemoSk+PJnTJbzCkcXH2nXuOSZ2teyEsE7GnnerWRvJov2Aw9BojyaB/3rvfauAuLHvOrsAzmx46khV3a1r5YoGPBmOBfSzQIj3XNUwvupmX7tXLwDwaHI1ylqrkcN+cv1Ha1le3f+mTlUNI9yHBpww2ZLvEvgKanMfsJEixr3/Ic0vO2HI3ObneeF/wesIgNMQJ3L2HEkDh6nzalj4EsndZpTMSxz5sP9HjhTeBzUtEgcF3ZPE65bSOmETyUSTHLbgSDHcDZ8CCDhQb9QYXP4Lg2n5mJQ1yuIdoki7LAsXbp/br8aNwUJP88ciKGOfR1EH5g0JLL8T/geUsGqit2mmZdAvuIHF51PR70ai3Bp8visUKwvhlEkJYGvxWoVkfheJkqVhyL+y4V8IyV9h0xVK8HNL6aRXQlFHWuIWW7lLykh58jd8P8o8utqiptAXcI9aqLne0BZAjPgLU5tsgRst+QCB+6wfXLJB5lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(396003)(136003)(39830400003)(376002)(1076003)(186003)(26005)(66556008)(107886003)(66946007)(7416002)(86362001)(66476007)(5660300002)(33656002)(316002)(6916009)(53546011)(52116002)(38100700002)(508600001)(6506007)(54906003)(966005)(8936002)(2906002)(4326008)(44832011)(83380400001)(6512007)(8676002)(6486002)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?emkQuIe89msFRVvG97UAR/susZIbT8gz/HuZlpaqzhfe54MO6GIqcXERW1?=
 =?iso-8859-1?Q?OVpx6zGdUo/iPixKiDI9lOS0NtxvbB9d89qDEwPzHB9WwRdPKvCcLeJx46?=
 =?iso-8859-1?Q?Z12sCMpeKQU0Ojvu+qZTjr4h8wniVQf4I2/iYqsqCpv8R266IZLq5cpz0h?=
 =?iso-8859-1?Q?zfxFKtGOYKev8aDwbxviZfqAFmnAypYr5Mwmce4TPaYAjChNg3mXECIBfF?=
 =?iso-8859-1?Q?g7e5QJ7reKWziK4QSEwagnihtS4yjXdYQNR0dLEnFfInlQ6BTt9wbdJ9Sm?=
 =?iso-8859-1?Q?i4wqfG57zbt6wu+u5Jtgphtx2gsMOfqBK1umpnoPUG3MaArg1RVcMxfYm5?=
 =?iso-8859-1?Q?Cmnr4YgwtVnbDs/2dskTjtHOGzGPc6WfDs9MtyfyGexCl0iNaDJxgOad1Z?=
 =?iso-8859-1?Q?G4eH/b+iByZ8aVg1rogkSnrbY8xfihgl4P4g5AxzwITHREgxiDVxO7yLUh?=
 =?iso-8859-1?Q?YIGctShzgkVyZol6bVpFmsIPK4jagTF/eIQ2Y8kV+WIJPkiiBeJg6TuTqI?=
 =?iso-8859-1?Q?Zvy6nqlzBC/vUJEBns7is1+jbc1yJjWwsur4u3zvfEgGmDGwp2hAVRltaI?=
 =?iso-8859-1?Q?7us4ZRNW08LPfSdtSu0msy+/Oeq3Et59dejnTP2c7UInWITZpezkDtQPvi?=
 =?iso-8859-1?Q?ouyg7TAP06b1YTSF+N70NvNXH8HsHggxGyP18tNP6roNPE1NoGvn8dFzpm?=
 =?iso-8859-1?Q?ij8Az6usY6ZAjcXO5c4JCDj6n/25oAybCPGHMmr+6UnBZn2T1r7H0r3Eik?=
 =?iso-8859-1?Q?ONyTm6Eaqp2rkcLEvwBjTtW+a+lEUlh8nwlYQ27Mcl1ezSB/7GzaD4cyLq?=
 =?iso-8859-1?Q?SswOw2Qr/ZLFg1CxcQdCrC0X34PB6dvGOb/JOOK2rCHVwF66Xr+H3q5uBp?=
 =?iso-8859-1?Q?p2Lmba1+AdqbB9qBN+qI8AuZOz6PjdZjrylD7xccBOSxeNsVCNcUQKqjVo?=
 =?iso-8859-1?Q?yGBZKpXmnxI2b5qK1jiaogzKEw5f0Z0h1jmT/YBxK0StvheB561q5+KtRB?=
 =?iso-8859-1?Q?Fnu1+EjSU2XAhy0no48DI20H/fPY90P4uSyxJrzImHsH/Lx6lWj4c78I+/?=
 =?iso-8859-1?Q?CgIZIEd8aRa2AjIgPI8BUcyLardqolMvlJGS+hvzt6pVIDhvbnYnGyDWM7?=
 =?iso-8859-1?Q?ryPHeeojfXW8UPjFbG80Wo2GKxf//noNwxBB6rvM56O5xhojzaWh8xtrSV?=
 =?iso-8859-1?Q?Lpo2RZuqsI8kmLax80d0DP00lWSJC53+zSNBnKmbSDf6/gMcfIH2nfQq5F?=
 =?iso-8859-1?Q?oc4xBNgn7VVpvlPMubDjfrauwvSdaM50a82VqGL1Tg0VutbJn9n4A2OfCS?=
 =?iso-8859-1?Q?pnLOmM6buhjEY4wHsqiiHA3TobeMo+jZXKX4KJd5XVYZMuNYw9/vqtaFrc?=
 =?iso-8859-1?Q?qgNxqGaMNPGidY631ZNB5e2/IN3Ehzo+UcT6//yJL2WIP0Vf6++i7gTBau?=
 =?iso-8859-1?Q?hZ7iYtqR5SzMvVWYusxy5A1n7X/FHroW3+t7shHnJACUqmG5GbG6mzVoBQ?=
 =?iso-8859-1?Q?k7ILCWTHpbq7prN305uWYTXOE4/WSR2bmoOTetTTsyXBTFi5tJZw6AvrEs?=
 =?iso-8859-1?Q?4KAfNKTvIDdIAD2OtM1cw5ui/EoZZUVEnR0skLVTpw3uBAoI5kPUkNnHmQ?=
 =?iso-8859-1?Q?vaq5vOPYRd4t9zFyu796UBdH8ReoaxksQBq0Xrg2r1YD36w68thWlqddtE?=
 =?iso-8859-1?Q?3qFE7SkupsE9I2L7jn5t9TtREmkWvC2VUZZXHZRDLvpS/uHKHMvZEMcuqG?=
 =?iso-8859-1?Q?ze/g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea80c6ee-efa3-4b64-3e52-08d9eabeff20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 04:53:49.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfiHYmqSR+aZrAK3bJeNzvb/Wjp/BvXbDM8ViqCHjQgdknXJWVnlpMSi3R2OCunBFzQSR4f/f2/jXbf1X4Qz8ms83gjyudHQtYTGMg4mmBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5335
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 07, 2022 at 07:26:29PM +0100, Jiri Olsa wrote:
> On Mon, Feb 07, 2022 at 06:57:20PM +0100, Jiri Olsa wrote:
> > On Mon, Feb 07, 2022 at 09:42:25AM -0800, Andrii Nakryiko wrote:
> > > On Mon, Feb 7, 2022 at 8:00 AM Yinjun Zhang <yinjun.zhang@corigine.com> wrote:
> > > >
> > > > When reworking btf__get_from_id() in commit a19f93cfafdf the error
> > > > handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> > > > if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> > > > callers of btf__get_from_id(), after the rework it is. This lead to a
> > > > change in behavior in print_key_value() that now prints an error when
> > > > trying to lookup keys in maps with no btf available.
> > > >
> > > > Fix this by following the way used in dumping maps to allow to look up
> > > > keys in no-btf maps, by which it decides whether and where to get the
> > > > btf info according to the btf value type.
> > > >
> > > > Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
> > > > Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> > > > Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> > > > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > > > ---
> > > >  tools/bpf/bpftool/map.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > > > index cc530a229812..4fc772d66e3a 100644
> > > > --- a/tools/bpf/bpftool/map.c
> > > > +++ b/tools/bpf/bpftool/map.c
> > > > @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
> > > >         json_writer_t *btf_wtr;
> > > >         struct btf *btf;
> > > >
> > > > -       btf = btf__load_from_kernel_by_id(info->btf_id);
> > > > -       if (libbpf_get_error(btf)) {
> > > > -               p_err("failed to get btf");
> > > > +       btf = get_map_kv_btf(info);
> > > > +       if (libbpf_get_error(btf))
> > > 
> > > See discussion in [0], it seems relevant.
> > > 
> > >   [0] https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/
> > 
> > I checked and this patch does not fix the problem for me,
> > but looks like similar issue, do you have test case for this?
> > 
> > mine is to dump any no-btf map with -p option
> 
> anyway I think your change should go in separately,
> I can send change below (v2 for [0] above) on top of yours
> 
> thanks,
> jirka
> 

Yeah, I agree they are separate issues, and my test case is also
simple, just lookup a key in a no-btf map, example:
# ./bpftool map create /sys/fs/bpf/xx type array key 4 value 4 entries 2 name def
# ./bpftool map lookup name def key 0 0 0 0
Error: failed to get btf

> 
> ---
>  tools/bpf/bpftool/map.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c66a3c979b7a..8562add7417d 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -805,29 +805,28 @@ static int maps_have_btf(int *fds, int nb_fds)
>  
>  static struct btf *btf_vmlinux;
>  
> -static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
> +static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
>  {
> -	struct btf *btf = NULL;
> +	int err = 0;
>  
>  	if (info->btf_vmlinux_value_type_id) {
>  		if (!btf_vmlinux) {
>  			btf_vmlinux = libbpf_find_kernel_btf();
> -			if (libbpf_get_error(btf_vmlinux))
> +			err = libbpf_get_error(btf_vmlinux);
> +			if (err) {
>  				p_err("failed to get kernel btf");
> +				return err;
> +			}
>  		}
> -		return btf_vmlinux;
> +		*btf = btf_vmlinux;
>  	} else if (info->btf_value_type_id) {
> -		int err;
> -
> -		btf = btf__load_from_kernel_by_id(info->btf_id);
> -		err = libbpf_get_error(btf);
> -		if (err) {
> +		*btf = btf__load_from_kernel_by_id(info->btf_id);
> +		err = libbpf_get_error(*btf);
> +		if (err)
>  			p_err("failed to get btf");
> -			btf = ERR_PTR(err);
> -		}
>  	}
>  
> -	return btf;
> +	return err;
>  }
>  
>  static void free_map_kv_btf(struct btf *btf)
> @@ -862,8 +861,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	prev_key = NULL;
>  
>  	if (wtr) {
> -		btf = get_map_kv_btf(info);
> -		err = libbpf_get_error(btf);
> +		err = get_map_kv_btf(info, &btf);
>  		if (err) {
>  			goto exit_free;
>  		}
> @@ -1054,11 +1052,8 @@ static void print_key_value(struct bpf_map_info *info, void *key,
>  	json_writer_t *btf_wtr;
>  	struct btf *btf;
>  
> -	btf = btf__load_from_kernel_by_id(info->btf_id);
> -	if (libbpf_get_error(btf)) {
> -		p_err("failed to get btf");
> +	if (get_map_kv_btf(info, &btf))
>  		return;
> -	}
>  
>  	if (json_output) {
>  		print_entry_json(info, key, value, btf);
> -- 
> 2.34.1
> 
