Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309524C709
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHTVMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:12:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgHTVL7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 17:11:59 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KL3cJs032323;
        Thu, 20 Aug 2020 14:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Qp9NrPM3m8vCEeaAtycq1Q5AdDcKX8C5y8fycqBPI70=;
 b=IuCvmY2ztUUxrskhCSE+tb+RrhLkyX4XHzdTNlv3b7Zj5wLRr2lXYPbNwcZ8T9YzhA8Q
 q97rhbtEwqsv1b9vNBfpyqh5fdnq5KctLxS+oolbeRAyHMonckD3/JqFxoLaNDtRFrB/
 mjmjsc1K4kmTGrHwZaILTOHFiVpNr/g1Utc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 331crbds7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Aug 2020 14:11:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 14:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbcyB6eVyircTrtZlE7X+lWpzOSCd8HelJVJT9jvQ4syDxQiIkmZ8+vhCYENI9+AI6JR0mw9sz+ZhdqUByEnsUcjiKuVMDyvqpWccKrswKy57ISXnKEqO/fRx9Zld4CJOLk6q43k/lqkIZ+UFyBx60BDtPFsZEFFYY0WFl1sbI5Yp+XcINp0LMwn2DnItT9cyCwzWPDAec7kcH9aghtyXa8Y5kvRbmbDoanoPf29P1Oq53+UtiQXot0223Obpe7NjDobpU8tsv2frqY11dDss9yTcWVfij1QwIURisfHvO/m/VYhBddhU1VRu6caatv94bguDlBSeN6SBftBoquESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp9NrPM3m8vCEeaAtycq1Q5AdDcKX8C5y8fycqBPI70=;
 b=dDJGQJJGYgMtsGeCedUGYVM0Q6zpOeQViGoWfdgAd3Z2a+0LOMw2AEDXETWEAu2iCT0mOdcNWT1Eu99VNnd6mchJSlkWneufUSU3565Z9iq8k3VJnlB+Zchy1QekorUJNRkHgAI4YML7Fh+9yZZuKUeFOn8RispNH2A0FXtME58BoITtXl3u9/dJ/5do/l75dnPmVE+h6SAeqOmbWDPNKFG6Sh4pMsqdtpqxclIn6vdsoZOc5o6WYRWgV5AJEO//1G6tT/CKU6vHXczD3aX3XNF7WsmYlw4jz5rtAtWu+/beu2y5/a9/x7TR5D0ooiSSeLfbIHMdt97dCfXMBB9nLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp9NrPM3m8vCEeaAtycq1Q5AdDcKX8C5y8fycqBPI70=;
 b=WV2YBTUQcBvPFarJcu/eFszJIC7VoR47QsATYBDJ1oUiJ/RgzSxZftwYkQBFW2ZSIsQE5dRWx72Qfix30vH2LSfRZRizhxe3wsyDgjxRA3CUR0dbKcymAVDH6dhwRS5VzlIvTJkpXT+i0YjGmu+7gHV6MSe+/Wi/BqTH2N5LXZs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3463.namprd15.prod.outlook.com (2603:10b6:a03:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Thu, 20 Aug
 2020 21:11:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 21:11:36 +0000
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
To:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com>
Date:   Thu, 20 Aug 2020 14:11:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:208:120::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 21:11:34 +0000
X-Originating-IP: [2620:10d:c091:480::1:7a86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2cdc99-8ef8-4ec5-8f3b-08d8454d9f3a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3463:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34632BD3A032AF3A0FCA80CDD35A0@BYAPR15MB3463.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1N3196+nP9tRscykfjrUNOym8Uw+ULIQhCRme+dtqXJ0/Mu1YA3MGKkiJJ42nFInlYBeyutI67cY5b1+O8Co4cDEZJojRKr8zTEJxxD5ETGLCp06RZ7VyQ0bpUqaLn0EaZcX+aN6YLOKLmaXMlm/CuxqcM9jZREKIozUVLRoY/u3SHQV90AM+b/JqxH7TxTc8Xsa+GLOT78W6glbU5hBndl2YaOsXxhsuPSdtSdPEvdF7g/E8RDn1cMQV0iZX0y3JA6z+5wMRFCbosincLbMcQrafAMRVxX1gegAfG2ULrNcnm9H+dpBWu0xHwQkx+C1bGe1g/c7i/2uCTfpACOARZ+MHcViL9z3R7JnVNturB2OlUJHa65/5O1LPyEPKaDA/sD0rbGNn5Qq2SPAgMnwgDsI+YqVZB8JuoZaaAyjqt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(16576012)(8676002)(36756003)(2616005)(4326008)(186003)(6486002)(83380400001)(53546011)(8936002)(2906002)(316002)(956004)(86362001)(31686004)(478600001)(52116002)(66946007)(66476007)(6666004)(5660300002)(31696002)(66556008)(54906003)(110011004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: M4n77qdvGwBcaesGwI8MhUeUG4SGKQg0NDyntB4q9/RcGvLs2VUotYFzf4oD30Useh3JXE6Y4pirVjxhrEoCOFnnhRWhPcWQVXNaRiHQ0ncxfMPEipi1Wml0v1oBDc7xt4zlQz39nsGluqdkDmuEQ3CLI1zB/Z1yLAa5iH/Anj6+8gP/ydX+Zuek/IeKtOCv76ImblypFzRgLkgY6lgIJdtp26bpZKdgjDy8xml1ShaBCL5JO3zkoyKfbtvZDlp6yCsZzU8VFQ/4O0cpnUdK9NxFvJShqtciDzMmNeeAw0MpLV7l4bFJG3QlzkSlRdGx5RkuxZ8/1ckpetIBx0g5udKz4QTTHg0LDGorXM+slfEdPnhGHVCGGcIUyZZKpXZysuSjQXFd59jfpJOccPhzNt2S8FJOGeHPlvNwakamJ4T/aqml1IHuUEyJznD92IsPFFJYtmhr7iTiFaaK0V3CU9eNawBTAe2ipNqiy7yxhhnx3fuA99HqBIWUvZ7auhYUnKIHHB8nvgKUbvM9avSnRaNHO5potR1owRTt6zlFjynVxPqsTaNBZT4u/ZJ56yDXZaoAWpkmbQO4GOas1sIWvlX5yXIAE+5ufhAXPNqgb5WE98zQ3LET8VsB+ezM/WMrx9q5zLw+CZVt8CKi4HPnEymaOmcFhV8yh0qzrXeZXGomqj/36Ot2tI+r0IQ/dxg7
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2cdc99-8ef8-4ec5-8f3b-08d8454d9f3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 21:11:36.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sAbD59GLZeFoomWe2P2rd8bN9QRAiWwzmIftoUd7SO/1utRIvP25kS5PLmLLN+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3463
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200171
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/20/20 2:42 AM, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Added a flag "--metadata" to `bpftool prog list` to dump the metadata
> contents. For some formatting some BTF code is put directly in the
> metadata dumping. Sanity checks on the map and the kind of the btf_type
> to make sure we are actually dumping what we are expecting.
> 
> A helper jsonw_reset is added to json writer so we can reuse the same
> json writer without having extraneous commas.
> 
> Sample output:
> 
>    $ bpftool prog --metadata
>    6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
>    [...]
>    	btf_id 4
>    	metadata:
>    		metadata_a = "foo"
>    		metadata_b = 1
> 
>    $ bpftool prog --metadata --json --pretty
>    [{
>            "id": 6,
>    [...]
>            "btf_id": 4,
>            "metadata": {
>                "metadata_a": "foo",
>                "metadata_b": 1
>            }
>        }
>    ]
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   tools/bpf/bpftool/json_writer.c |   6 ++
>   tools/bpf/bpftool/json_writer.h |   3 +
>   tools/bpf/bpftool/main.c        |  10 +++
>   tools/bpf/bpftool/main.h        |   1 +
>   tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
>   5 files changed, 155 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
> index 86501cd3c763..7fea83bedf48 100644
> --- a/tools/bpf/bpftool/json_writer.c
> +++ b/tools/bpf/bpftool/json_writer.c
> @@ -119,6 +119,12 @@ void jsonw_pretty(json_writer_t *self, bool on)
>   	self->pretty = on;
>   }
>   
> +void jsonw_reset(json_writer_t *self)
> +{
> +	assert(self->depth == 0);
> +	self->sep = '\0';
> +}
> +
>   /* Basic blocks */
>   static void jsonw_begin(json_writer_t *self, int c)
>   {
> diff --git a/tools/bpf/bpftool/json_writer.h b/tools/bpf/bpftool/json_writer.h
> index 35cf1f00f96c..8ace65cdb92f 100644
> --- a/tools/bpf/bpftool/json_writer.h
> +++ b/tools/bpf/bpftool/json_writer.h
> @@ -27,6 +27,9 @@ void jsonw_destroy(json_writer_t **self_p);
>   /* Cause output to have pretty whitespace */
>   void jsonw_pretty(json_writer_t *self, bool on);
>   
> +/* Reset separator to create new JSON */
> +void jsonw_reset(json_writer_t *self);
> +
>   /* Add property name */
>   void jsonw_name(json_writer_t *self, const char *name);
>   
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 4a191fcbeb82..a681d568cfa7 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -28,6 +28,7 @@ bool show_pinned;
>   bool block_mount;
>   bool verifier_logs;
>   bool relaxed_maps;
> +bool dump_metadata;
>   struct pinned_obj_table prog_table;
>   struct pinned_obj_table map_table;
>   struct pinned_obj_table link_table;
> @@ -351,6 +352,10 @@ static int do_batch(int argc, char **argv)
>   	return err;
>   }
>   
> +enum bpftool_longonly_opts {
> +	OPT_METADATA = 256,
> +};
> +
>   int main(int argc, char **argv)
>   {
>   	static const struct option options[] = {
> @@ -362,6 +367,7 @@ int main(int argc, char **argv)
>   		{ "mapcompat",	no_argument,	NULL,	'm' },
>   		{ "nomount",	no_argument,	NULL,	'n' },
>   		{ "debug",	no_argument,	NULL,	'd' },
> +		{ "metadata",	no_argument,	NULL,	OPT_METADATA },
>   		{ 0 }
>   	};
>   	int opt, ret;
> @@ -371,6 +377,7 @@ int main(int argc, char **argv)
>   	json_output = false;
>   	show_pinned = false;
>   	block_mount = false;
> +	dump_metadata = false;
>   	bin_name = argv[0];
>   
>   	hash_init(prog_table.table);
> @@ -412,6 +419,9 @@ int main(int argc, char **argv)
>   			libbpf_set_print(print_all_levels);
>   			verifier_logs = true;
>   			break;
> +		case OPT_METADATA:
> +			dump_metadata = true;
> +			break;
>   		default:
>   			p_err("unrecognized option '%s'", argv[optind - 1]);
>   			if (json_output)
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index c46e52137b87..8750758e9150 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -90,6 +90,7 @@ extern bool show_pids;
>   extern bool block_mount;
>   extern bool verifier_logs;
>   extern bool relaxed_maps;
> +extern bool dump_metadata;
>   extern struct pinned_obj_table prog_table;
>   extern struct pinned_obj_table map_table;
>   extern struct pinned_obj_table link_table;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index d393eb8263a6..ee767b8d90fb 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -151,6 +151,135 @@ static void show_prog_maps(int fd, __u32 num_maps)
>   	}
>   }
>   
> +static void show_prog_metadata(int fd, __u32 num_maps)
> +{
> +	struct bpf_prog_info prog_info = {};
> +	struct bpf_map_info map_info = {};
> +	__u32 prog_info_len = sizeof(prog_info);
> +	__u32 map_info_len = sizeof(map_info);
> +	__u32 map_ids[num_maps];
> +	void *value = NULL;
> +	struct btf *btf = NULL;
> +	const struct btf_type *t_datasec, *t_var;
> +	struct btf_var_secinfo *vsi;
> +	int key = 0;
> +	unsigned int i, vlen;
> +	int map_fd;
> +	int err;

try to follow reverse christmas tree coding styple?

> +
> +	prog_info.nr_map_ids = num_maps;
> +	prog_info.map_ids = ptr_to_u64(map_ids);
> +
> +	err = bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
> +	if (err || !prog_info.nr_map_ids)
> +		return;

print out something for "err" case and "!prog_info.nr_map_ids" case?
The same for some other below returns.

> +
> +	for (i = 0; i < prog_info.nr_map_ids; i++) {
> +		map_fd = bpf_map_get_fd_by_id(map_ids[i]);
> +		if (map_fd < 0)
> +			return;
> +
> +		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
> +		if (err)
> +			goto out_close;
> +
> +		if (map_info.type != BPF_MAP_TYPE_ARRAY)
> +			goto next_map;
> +		if (map_info.key_size != sizeof(int))
> +			goto next_map;
> +		if (map_info.max_entries != 1)
> +			goto next_map;
> +		if (!map_info.btf_value_type_id)
> +			goto next_map;
> +		if (!strstr(map_info.name, ".metadata"))
> +			goto next_map;
> +
> +		goto found;
> +
> +next_map:
> +		close(map_fd);
> +	}
> +
> +	return;
> +
> +found:
> +	value = malloc(map_info.value_size);
> +	if (!value)
> +		goto out_close;
> +
> +	if (bpf_map_lookup_elem(map_fd, &key, value))
> +		goto out_free;

Not sure whether we need formal libbpf API to access metadata or not.
This may help other applications too. But we can delay until it is
necessary.

If we can put metadata in skeleton like
    <metadata_type>   *metadata;
and then it will be very easy for users to access it.

> +
> +	err = btf__get_from_id(map_info.btf_id, &btf);
> +	if (err || !btf)
> +		goto out_free;
> +
> +	t_datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
> +	if (BTF_INFO_KIND(t_datasec->info) != BTF_KIND_DATASEC)
> +		goto out_free;
> +
> +	vlen = BTF_INFO_VLEN(t_datasec->info);
> +	vsi = (struct btf_var_secinfo *)(t_datasec + 1);
> +
> +	if (json_output) {
> +		struct btf_dumper d = {
> +			.btf = btf,
> +			.jw = json_wtr,
> +			.is_plain_text = false,
> +		};
> +
> +		jsonw_name(json_wtr, "metadata");
> +
> +		jsonw_start_object(json_wtr);
> +		for (i = 0; i < vlen; i++) {
> +			t_var = btf__type_by_id(btf, vsi[i].type);
> +
> +			if (BTF_INFO_KIND(t_var->info) != BTF_KIND_VAR)
> +				continue;
this should not happen.
> +
> +			jsonw_name(json_wtr, btf__name_by_offset(btf, t_var->name_off));
> +			err = btf_dumper_type(&d, t_var->type, value + vsi[i].offset);
> +			if (err)
> +				break;
> +		}
> +		jsonw_end_object(json_wtr);
> +	} else {
> +		json_writer_t *btf_wtr = jsonw_new(stdout);
> +		struct btf_dumper d = {
> +			.btf = btf,
> +			.jw = btf_wtr,
> +			.is_plain_text = true,
> +		};
> +		if (!btf_wtr)
> +			goto out_free;
> +
> +		printf("\tmetadata:");
> +
> +		for (i = 0; i < vlen; i++) {
> +			t_var = btf__type_by_id(btf, vsi[i].type);
> +
> +			if (BTF_INFO_KIND(t_var->info) != BTF_KIND_VAR)
> +				continue;
this should not happen.
> +
> +			printf("\n\t\t%s = ", btf__name_by_offset(btf, t_var->name_off));
> +
> +			jsonw_reset(btf_wtr);
> +			err = btf_dumper_type(&d, t_var->type, value + vsi[i].offset);
> +			if (err)
> +				break;
> +		}
> +
> +		jsonw_destroy(&btf_wtr);
> +	}
> +
> +out_free:
> +	btf__free(btf);
> +	free(value);
> +
> +out_close:
> +	close(map_fd);
> +}
> +
>   static void print_prog_header_json(struct bpf_prog_info *info)
>   {
>   	jsonw_uint_field(json_wtr, "id", info->id);
> @@ -228,6 +357,9 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
>   
>   	emit_obj_refs_json(&refs_table, info->id, json_wtr);
>   
> +	if (dump_metadata)
> +		show_prog_metadata(fd, info->nr_map_ids);
> +
>   	jsonw_end_object(json_wtr);
>   }
>   
> @@ -297,6 +429,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>   	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
>   
>   	printf("\n");
> +
> +	if (dump_metadata)
> +		show_prog_metadata(fd, info->nr_map_ids);
>   }
>   
>   static int show_prog(int fd)
> 
