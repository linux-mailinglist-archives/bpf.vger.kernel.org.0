Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC1251E80
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYRjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 13:39:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgHYRjx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 13:39:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07PHZOJh018389;
        Tue, 25 Aug 2020 10:39:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Klzn/5GDglqr9+v3V+ruJgQ1fcQUY3wyLgew7EBfK9Y=;
 b=qNzb0qmhWiFEbVWt0StFqyk+UsfRhxDJ33fso+UC8egIO5NS9IVIIGlR7E+HRxhif/fm
 8fELq7hdMvmJMtrb/IdMynoud2IU+nB8FuQMewkFi76B0DS22cwdXu6VIF2AmxLuZmPm
 p8Ce1oQZskO7ws/rB+gbhg4KKVkbBYAqTO4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 332xuwqk3j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Aug 2020 10:39:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 10:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXv0Gxa2jpZVRgYWCryVURJkJ1jbXizXaqzb2HAKVy0qPqKdnnnHhK1W53jiWfpMOzOfpbpIpMi+2gnZN3ShVBSMQQtaauVf0nncHonquA2Ew5sjl7l6+2cB2SuI4wJn/y6G0MBX3RM72aeUWoC/eQQd8WUkAfbUsA9KbtzkWZ5EtT8FeXuRdQ1k0Sz7xE0aJVAUT4FEd8bBPyi9oTRQQJSO5+6JfDITAuVC3oM9ndQYVF/qBlANVbp8wh9tEP2K0r/eyyUcn4/g0tJkUBJjG1rPYBZVTaIEFugBpSUhpw5ikmp1ZqIwzZHEeVKsQ4DZ/sJt1E488GnRJpgxfRJrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klzn/5GDglqr9+v3V+ruJgQ1fcQUY3wyLgew7EBfK9Y=;
 b=UErgu/aDkI+1LT9EIvsNMMUrfyOEK1I/YiaRlQdtY+ILipU8/QPDKdulHRwY1jW69Umk1XTOjXC2Pu0qFBARDKHIGIP/fugOmPj72ADJrNcfhpiDN2NU4SIqnzMysMM6NDDMjLvd28POUziK0ZhMQFaPdvhhFq4dhiCsXyJC9wtUb5dpBfDpnGophyqq/3kBQjmsi1kRrSJcjtdamoYz0xxO+dHZChvTRuc2DpB5DHBh2rh2eAmUklyIn6xqD+n9htALyrhp7A/gPZ+Jvvz8iTapzB9UYNZCkEIKBas3VPgc54dVXGzFOAATOAlwO678zcOxkAsmOtq4P2vYtOPiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klzn/5GDglqr9+v3V+ruJgQ1fcQUY3wyLgew7EBfK9Y=;
 b=UuSmATjsV+Hkcmc1EaEEgz2XA4mp38JBrtWvVvPmvpcG6e8u8PVyhDuqlL9IkLv9TzQf5ksE3uFmmmNZWCR1ny43w6evT6g6HDmhw4xCsc6+7+/MIKDKKcqdmGCYRh38EFU0weJKhClLX6iw7xw9WUIreyjd34Xx8owGhAuaxMM=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 17:39:30 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 17:39:30 +0000
Date:   Tue, 25 Aug 2020 10:39:25 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v9 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200825173925.tmi4h5lomzwkciew@kafai-mbp.dhcp.thefacebook.com>
References: <20200823165612.404892-1-kpsingh@chromium.org>
 <20200823165612.404892-6-kpsingh@chromium.org>
 <20200825005249.tu4c54fg36jt3rh4@kafai-mbp.dhcp.thefacebook.com>
 <8d188285-96f5-3b17-126f-5e842702e339@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d188285-96f5-3b17-126f-5e842702e339@chromium.org>
X-ClientProxiedBy: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 17:39:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:ae73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab68737-e0df-4405-a02e-08d8491dd21f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR15MB300078C9FEAFB6D5463E9990D5570@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRdr7YzkENZZg3wuvWfPtgcYY0zps9ZDtfNdNrvYfsy28ScIu0QJKUz/jMkUB4Hqv2PEbgoN8OAPlNEbZ6z73MVXwgCGei8Q7FhXlm27xhGRwz6Xp9ZAML6ZHtS+0iB3e2TFXgLF3BsQuXICYO0+QrL1txlh/UIz81puVeHUMiHM+D+hvoiZYDePfWhk3fM+2zW3X++HOFjfJiQJEQnHua3W74c6oO4LfuIOlUWkMVRSZBgF6C3F76kPBuA10yq3Pt/7bAgx1AogOsbrL5Gxy0VPnRfuJLSATmr2qKiT5ampWj4rLZURwNXrJHi8W9AJ/eSCK/WIz9kCKbFly6e6ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(9686003)(6666004)(316002)(53546011)(66556008)(8936002)(66476007)(66946007)(2906002)(83380400001)(54906003)(8676002)(16576012)(86362001)(52116002)(478600001)(6486002)(4326008)(5660300002)(956004)(6916009)(186003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AXbB41vLHsgKSuQuyQGO5XbzkbqGNiYe7FJY9F/TGiksU1KrwraxI1ik30oIGN/B+e/AtVRfEQ5r5ytRUeMFEzBKyQeGgxvIxA2T2WdL7jC8ZoTdU2j8qaoia7H2vFMO7QX+2NqaSna5oXADE2h+8MdEAgxDVBV8AcUhmBIbxGH9K/fU8A8LVaweXu4/13mf3yjeESJXFRWqpDhoJTXMWgivZ2e+MSaXtv17G9w9Hjoe+wSVY5QHpvczKBUvVuMNnS1yBT80C1ByaILiRfFW6E/wDYLd3PcFHmL6hRKMk2Sv7piUM5XSBq+TccfVoQ3nfofHxeWRnG7YROZcGjzDQxwj64atJtx8aTVjMQBnDgNALGxKuWcCxQyniQcKkOp0bA02iQzX3Q2iQNh3OZtKGlR9p7hERyMgyH8GnCH8uK2g9P6A9AMAP9QDopf81YUz66MBc6or1xBPnUndyNNouLC0Hm6vZlS2Rfv+uWvXILMszPvy3IjdPvZP/WZabT6aEmeTMyGWSENMQIwzgjFntF80B8j5cbl7pqt2pUo/sq9d4BUdE5O+fZguijB1j4Quoc46L8JRmxnuqb45FqYb+NLrYbLavGkZv6x0PQom/kx0nTKYbt2GKMaPA1Im26ysU6o5oJb+8vNTRiXiSZRu/JoZ+e7oiwrupWduLw1yhtw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab68737-e0df-4405-a02e-08d8491dd21f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 17:39:30.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFtcaDk16qNQ/8xx6U1ui73COFownj4Xx68b1mPSikIqKyNz/K0jPCJKFunG+MQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_08:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=1 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=870 phishscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 25, 2020 at 04:10:26PM +0200, KP Singh wrote:
> 
> 
> On 8/25/20 2:52 AM, Martin KaFai Lau wrote:
> > On Sun, Aug 23, 2020 at 06:56:10PM +0200, KP Singh wrote:
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> Similar to bpf_local_storage for sockets, add local storage for inodes.
> >> The life-cycle of storage is managed with the life-cycle of the inode.
> >> i.e. the storage is destroyed along with the owning inode.
> >>
> >> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> >> security blob which are now stackable and can co-exist with other LSMs.
> >>
> > [ ... ]
> > 
> >> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> >> new file mode 100644
> >> index 000000000000..b0b283c224c1
> >> --- /dev/null
> >> +++ b/kernel/bpf/bpf_inode_storage.c
> 
> [...]
> 
> >> +
> >> +DEFINE_BPF_STORAGE_CACHE(inode_cache);
> >> +
> >> +static struct bpf_local_storage __rcu **
> >> +inode_storage_ptr(void *owner)
> >> +{
> >> +	struct inode *inode = owner;
> >> +	struct bpf_storage_blob *bsb;
> >> +
> >> +	bsb = bpf_inode(inode);
> >> +	if (!bsb)
> >> +		return NULL;
> > just noticed this one.  NULL could be returned here.  When will it happen?
> 
> This can happen if CONFIG_BPF_LSM is enabled but "bpf" is not in the list of
> active LSMs.
> 
> > 
> >> +	return &bsb->storage;
> >> +}
> >> +
> >> +static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> >> +							   struct bpf_map *map,
> >> +							   bool cacheit_lockit)
> >> +{
> 
> [...]
> 
> > path first before calling the bpf_local_storage_update() since
> > this case is specific to inode local storage.
> > 
> > Same for the other bpf_local_storage_update() cases.
> 
> If you're okay with this I can send a new series with the following updates.
> 
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index b0b283c224c1..74546cee814d 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -125,7 +125,7 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
>  
>         fd = *(int *)key;
>         f = fget_raw(fd);
> -       if (!f)
> +       if (!f || !inode_storage_ptr(f->f_inode))
>                 return -EBADF;
>  
>         sdata = bpf_local_storage_update(f->f_inode,
> @@ -171,6 +171,14 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>         if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>                 return (unsigned long)NULL;
>  
> +       /* explicitly check that the inode_storage_ptr is not
> +        * NULL as inode_storage_lookup returns NULL in this case and
> +        * and bpf_local_storage_update expects the owner to have a
> +        * valid storage pointer.
> +        */
> +       if (!inode_storage_ptr(inode))
> +               return (unsigned long)NULL;
LGTM
